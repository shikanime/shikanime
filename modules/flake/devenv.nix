{ inputs, ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        enableDefaultExcludes = true;
        programs = {
          hclfmt.enable = true;
          nixfmt.enable = true;
          prettier.enable = true;
          shfmt.enable = true;
          statix.enable = true;
          terraform.enable = true;
        };
        projectRootFile = "flake.nix";
        settings.global.excludes = [
          "LICENSE"
        ];
      };
      devenv = {
        modules = [
          inputs.devlib.devenvModule
        ];
        shells = {
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
              pkgs.marksman
              pkgs.sapling
              pkgs.scaleway-cli
              pkgs.skaffold
              pkgs.taplo
            ];
          };
        };
      };
    };
}
