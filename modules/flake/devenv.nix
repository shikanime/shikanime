{ inputs, ... }:

{
  perSystem =
    {
      lib,
      pkgs,
      ...
    }:
    {
      devenv.shells.default = {
        imports = [
          inputs.devlib.devenvModules.git
          inputs.devlib.devenvModules.nix
          inputs.devlib.devenvModules.opentofu
          inputs.devlib.devenvModules.shell
          inputs.devlib.devenvModules.shikanime
        ];

        github.settings.workflows = {
          containers = {
            name = "Containers";
            on = {
              push = {
                branches = [
                  "main"
                  "release-[0-9]+.[0-9]+"
                ];
                tags = [
                  "v?[0-9]+.[0-9]+.[0-9]+*"
                ];
              };
            };
            jobs.build = {
              permissions.packages = "write";
              "runs-on" = "ubuntu-24.04-arm";
              steps = [
                {
                  id = "createGithubAppToken";
                  uses = "actions/create-github-app-token@v1";
                  "with" = {
                    app-id = "\${{ vars.OPERATOR_APP_ID }}";
                    private-key = "\${{ secrets.OPERATOR_PRIVATE_KEY }}";
                    permission-contents = "write";
                  };
                }
                {
                  uses = "actions/checkout@v4";
                  "with".token = "\${{ steps.createGithubAppToken.outputs.token || secrets.GITHUB_TOKEN }}";
                }
                {
                  uses = "cachix/install-nix-action@v30";
                  "with".github_access_token =
                    "\${{ steps.createGithubAppToken.outputs.token || secrets.GITHUB_TOKEN }}";
                }
                {
                  uses = "cachix/cachix-action@v16";
                  "with" = {
                    authToken = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
                    name = "shikanime";
                  };
                }
                {
                  uses = "docker/login-action@v3";
                  "with" = {
                    registry = "ghcr.io";
                    username = "\${{ github.actor }}";
                    password = "\${{ secrets.GITHUB_TOKEN }}";
                  };
                }
                { run = "nix run nixpkgs#direnv allow"; }
                { run = "nix run nixpkgs#direnv export gha >> \"$GITHUB_ENV\""; }
                { run = "skaffold build --platform linux/amd64,linux/arm64"; }
              ];
            };
          };

          wakabox = {
            name = "Wakabox";
            on = {
              schedule = [
                { cron = "0 0 * * *"; }
              ];
              workflow_dispatch = { };
            };
            jobs.wakabox = {
              runs-on = "ubuntu-latest";
              steps = [
                {
                  uses = "matchai/waka-box@v5.0.0";
                  env = {
                    GH_TOKEN = "\${{ secrets.WAKABOX_GITHUB_TOKEN }}";
                    GIST_ID = "\${{ vars.WAKABOX_GITHUB_GIST_ID }}";
                    WAKATIME_API_KEY = "\${{ secrets.WAKATIME_API_KEY }}";
                  };
                }
              ];
            };
          };
        };

        packages =
          with pkgs;
          [
            age
            docker
            scaleway-cli
            skaffold
          ]
          ++ lib.optional stdenv.hostPlatform.isLinux nixos-facter;

        sops = {
          enable = true;
          settings.creation_rules =
            let
              age = [
                "age1pwl9yz4k4255a4h8qz7lafce8wxhsul0cnqwmr8528fqgujlfshshv3z3g" # telsha
                "age1x9v4ps90txy9mk4392uya93tyzx40te4dvns4chg5s6q8mfy03ns74jpay" # nixtar
                "age18zmkeyxun4gflllelsmdhwjh5xpfwrqshdxrednv7zljphepxc6strhysn" # github-actions
              ];
            in
            [
              {
                path_regex = "secrets/fushi.enc.yaml";
                key_groups = [ { inherit age; } ];
              }
              {
                path_regex = "secrets/minish.enc.yaml";
                key_groups = [ { inherit age; } ];
              }
              {
                path_regex = "secrets/nishir.enc.yaml";
                key_groups = [ { inherit age; } ];
              }
              {
                path_regex = "secrets/nixtar.enc.yaml";
                key_groups = [
                  {
                    age = age ++ [
                      "age1um232l0h8wn9mtha2qf4f4mnf7ucjayvf5qxjvynatmasg8qg5mshekvjl" # host
                    ];
                  }
                ];
              }
              {
                path_regex = "secrets/telsha.enc.yaml";
                key_groups = [
                  {
                    age = age ++ [
                      "age1eak84xcr44yfqsg843rfu2xajxsyvjwh67a630htpnd0scy7yu5szjfh8d" # host
                    ];
                  }
                ];
              }
            ];
        };
      };
    };
}
