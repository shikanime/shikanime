{
  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        enableDefaultExcludes = true;
        programs = {
          hclfmt.enable = true;
          nixfmt.enable = true;
          prettier.enable = true;
          shfmt.enable = true;
          statix.enable = true;
          terraform.enable = true;
        };
        settings.global.excludes = [
          ".devenv/*"
          ".direnv/*"
          "*.png"
          ".terraform.lock.hcl"
          "LICENSE"
        ];
      };
      devenv.shells.default = {
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
        git-hooks.hooks = {
          actionlint.enable = true;
          deadnix.enable = true;
          flake-checker.enable = true;
        };
        packages = [
          pkgs.gh
        ];
      };
    };
}
