{ pkgs, ... }:

{
  pre-commit.hooks.hadolint.enable = true;
  packages = [
    pkgs.docker
    pkgs.nerdctl
  ];
}
