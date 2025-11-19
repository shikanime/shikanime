{ inputs, ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      devenv.shells = {
        default = {
          imports = [
            inputs.devlib.devenvModules.shikanime-studio
          ];
          cachix.push = "shikanime";
          github.workflows.check.settings.jobs.check.steps = [
            {
              name = "Check";
              uses = "actions/checkout@v3";
            }
          ];
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
