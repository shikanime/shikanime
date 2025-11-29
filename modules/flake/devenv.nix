{ inputs, ... }:

{
  perSystem =
    { config, pkgs, ... }:
    {
      devenv.shells = {
        default = {
          imports = [
            inputs.devlib.devenvModules.shikanime-studio
          ];
          cachix.push = "shikanime";
          languages.opentofu.enable = true;
          packages = [
            pkgs.direnv
            pkgs.gh
            pkgs.gnused
            pkgs.nushell
            pkgs.sapling
            pkgs.scaleway-cli
            pkgs.skaffold
            pkgs.sops
          ];
          github.workflows.push.settings.jobs.build = {
            runs-on = "ubuntu-latest";
            steps =
              with config.devenv.shells.default.github.actions;
              with config.devenv.shells.default.github.lib;
              [
                create-github-app-token
                checkout
                setup-nix
                docker-login
                {
                  run = mkWorkflowRun [
                    "nix"
                    "shell"
                    "nixpkgs#skaffold"
                    "--command"
                    "skaffold"
                    "build"
                    "--platform"
                    "linux/amd64,linux/arm64"
                  ];
                }
              ];
          };
        };
        build = {
          containers = pkgs.lib.mkForce { };
          packages = [
            pkgs.nushell
            pkgs.skaffold
          ];
        };
      };
    };
}
