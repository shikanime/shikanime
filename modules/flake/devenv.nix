{ self, ... }:

{
  flake.devenvModules.default = [
    ../devenv/air.nix
    ../devenv/github.nix
    ../devenv/gitignore.nix
  ];

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
        modules = self.devenvModules.default;
        shells.default = {
          cachix = {
            enable = true;
            push = "shikanime";
          };
          containers = pkgs.lib.mkForce { };
          gitignore = {
            enable = true;
            templates = [
              "repo:github/gitignore/refs/heads/main/Nix.gitignore"
              "repo:shikanime/gitignore/refs/heads/main/Devenv.gitignore"
              "tt:jetbrains+all"
              "tt:linux"
              "tt:macos"
              "tt:terraform"
              "tt:vim"
              "tt:visualstudiocode"
              "tt:windows"
            ];
          };
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
