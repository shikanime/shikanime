{ pkgs, ... }:

{
  pre-commit.hooks = {
    actionlint.enable = true;
    markdownlint.enable = true;
    shellcheck.enable = true;
  };
  packages = [
    pkgs.rubocop
  ];
}
