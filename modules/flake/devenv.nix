{ inputs, ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      devenv.shells = {
        imports = [
          inputs.devenv.devenvModules.shikanime-studio
        ];
        default = {
          cachix = {
            enable = true;
            push = "shikanime";
          };
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
