{ pkgs, ... }:

{
  home.homeDirectory = "/home/vscode";
  home.username = "vscode";
  nix.package = pkgs.nix;
}
