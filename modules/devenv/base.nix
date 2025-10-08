{ pkgs, ... }:

{
  cachix = {
    enable = true;
    push = "shikanime";
  };
  containers = pkgs.lib.mkForce { };
  languages.nix.enable = true;
  git-hooks.hooks = {
    actionlint.enable = true;
    deadnix.enable = true;
    flake-checker.enable = true;
  };
  packages = [
    pkgs.gh
    pkgs.sapling
    pkgs.gnused
    pkgs.marksman
  ];
}
