{ pkgs, ... }:

{
  imports = [
    ../profiles/base.nix
    ../profiles/xdg.nix
  ];

  home = {
    homeDirectory = "/home/shika";
    username = "shika";
  };

  targets.genericLinux.enable = true;

  nix.package = pkgs.nix;
}
