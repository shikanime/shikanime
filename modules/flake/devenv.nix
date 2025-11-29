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
            pkgs.nushell
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
