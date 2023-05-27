{ pkgs, ... }:

{
  pre-commit.hooks.actionlint.enable = true;
  packages = [
    pkgs.gh
    pkgs.glab
  ];
}
