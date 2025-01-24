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
          ".devenv/*"
          ".direnv/*"
          "*.png"
          "LICENSE"
        ];
      };
      devenv.shells.default = {
        cachix = {
          enable = true;
          push = "shikanime";
        };
        containers = pkgs.lib.mkForce { };
        languages = {
          nix.enable = true;
          opentofu.enable = true;
        };
        git-hooks.hooks = {
          actionlint.enable = true;
          deadnix.enable = true;
          flake-checker.enable = true;
          tflint.enable = true;
        };
        packages = [
          pkgs.gh
        ];
      };
    };
}
