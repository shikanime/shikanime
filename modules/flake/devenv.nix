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
          languages.opentofu.enable = true;
          packages = [
            pkgs.buildah
            pkgs.direnv
            pkgs.gh
            pkgs.gnused
            pkgs.nushell
            pkgs.sapling
            pkgs.scaleway-cli
            pkgs.skaffold
            pkgs.skopeo
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
