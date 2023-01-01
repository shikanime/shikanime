{ pkgs, ... }:

{
  pre-commit.hooks = {
    actionlint.enable = true;
    markdownlint.enable = true;
    shellcheck.enable = true;
    nixpkgs-fmt.enable = true;
    statix.enable = true;
    deadnix.enable = true;
  };
  packages = [
    pkgs.nixpkgs-fmt
    pkgs.rubocop
  ];
}
