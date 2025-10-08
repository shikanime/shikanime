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
          "*.png"
          "LICENSE"
        ];
      };
      devenv= {
        modules = [
          ../devenv/base.nix
        ];
        shells.default.imports = [
          ../devenv/tofu.nix
        ];
      };
    };
}
