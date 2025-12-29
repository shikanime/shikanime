{ inputs, ... }:

{
  perSystem =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      devenv.shells = {
        default = {
          imports = [
            inputs.devlib.devenvModules.docs
            inputs.devlib.devenvModules.formats
            inputs.devlib.devenvModules.github
            inputs.devlib.devenvModules.nix
            inputs.devlib.devenvModules.opentofu
            inputs.devlib.devenvModules.shell
            inputs.devlib.devenvModules.shikanime
          ];

          github.workflows.wakabox = {
            enable = true;
            settings = {
              name = "Wakabox";
              on = {
                schedule = [
                  { cron = "0 0 * * *"; }
                ];
                workflow_dispatch = null;
              };
              jobs.wakabox = {
                runs-on = "ubuntu-latest";
                steps = with config.devenv.shells.default.github.lib; [
                  {
                    uses = "matchai/waka-box@v5.0.0";
                    env = {
                      GH_TOKEN = mkWorkflowRef "secrets.WAKABOX_GITHUB_TOKEN";
                      GIST_ID = mkWorkflowRef "vars.WAKABOX_GITHUB_GIST_ID";
                      WAKATIME_API_KEY = mkWorkflowRef "secrets.WAKATIME_API_KEY";
                    };
                  }
                ];
              };
            };
          };

          packages = [
            pkgs.scaleway-cli
            pkgs.skaffold
          ]
          ++ lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.nixos-facter;

          sops = {
            enable = true;
            settings = {
              creation_rules =
                let
                  age = [
                    "age139fcg32lmhxupnz5wjex44jur7v7wzf9rttp2grnjmxhukck5dmqsd9zj5" # kaltashar
                    "age1pwl9yz4k4255a4h8qz7lafce8wxhsul0cnqwmr8528fqgujlfshshv3z3g" # telsha
                    "age1x9v4ps90txy9mk4392uya93tyzx40te4dvns4chg5s6q8mfy03ns74jpay" # nixtar
                  ];
                in
                [
                  {
                    path_regex = "secrets/kaltashar.enc.yaml";
                    key_groups = [
                      {
                        age = age ++ [
                          "age16pkwna5hq4hh03xfj6j5uew3wq6wfr5xgqgdmg6t3a27uz2dhuqsslh56c" # host
                        ];
                      }
                    ];
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
              stores.yaml.indent = 2;
            };
          };
        };
      };
    };
}
