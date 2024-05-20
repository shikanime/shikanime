{ pkgs, ... }:

{
  imports = [
    ../profiles/base.nix
    ../profiles/xdg.nix
  ];

  targets.genericLinux.enable = true;

  nix.package = pkgs.nix;
}
