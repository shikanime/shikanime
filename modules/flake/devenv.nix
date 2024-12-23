{
  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        enableDefaultExcludes = true;
        programs = {
          actionlint.enable = true;
          deadnix.enable = true;
          nixfmt.enable = true;
          prettier.enable = true;
          shfmt.enable = true;
          statix.enable = true;
          terraform.enable = true;
        };
        settings.global.excludes = [
          ".devenv/*"
          ".direnv/*"
          ".sl/*"
          "*.png"
          "LICENSE"
        ];
      };
      devenv.shells.default = {
        pre-commit.hooks.flake-checker.enable = true;
        containers = pkgs.lib.mkForce { };
        languages = {
          nix.enable = true;
          terraform = {
            enable = true;
            package = pkgs.opentofu;
          };
        };
        cachix = {
          enable = true;
          push = "shikanime";
        };
        packages = [
          pkgs.gh
        ];
      };
    };
}
