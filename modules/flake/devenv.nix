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
          ../devenv/air.nix
          ../devenv/github.nix
          ../devenv/gitnr.nix
        ];
        shells.default = {
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
            pkgs.scaleway-cli
            pkgs.gh
            pkgs.gnused
            pkgs.marksman
            pkgs.taplo
          ];
        };
      };
    };
}
