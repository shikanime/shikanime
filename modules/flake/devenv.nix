{
  perSystem =
    { pkgs, ... }:
    {
      devenv.shells = {
        default = {
          cachix = {
            enable = true;
            push = "shikanime";
          };
          containers = pkgs.lib.mkForce { };
          gitignore = {
            enable = true;
            enableDefaultTemplates = true;
          };
          github.enable = true;
          languages = {
            nix.enable = true;
            opentofu.enable = true;
            shell.enable = true;
          };
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
          treefmt = {
            enable = true;
            config = {
              enableDefaultExcludes = true;
              programs.prettier.enable = true;
              projectRootFile = "flake.nix";
            };
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
