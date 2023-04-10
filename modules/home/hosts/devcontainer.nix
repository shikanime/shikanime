{ pkgs, ... }:

{
  home.homeDirectory = "/home/vscode";
  home.username = "vscode";

  targets.genericLinux.enable = true;

  nix.package = pkgs.nix;
}
