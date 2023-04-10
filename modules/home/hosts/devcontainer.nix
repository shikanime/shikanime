{ pkgs, lib, ... }:

with lib;

{
  home.homeDirectory = "/home/vscode";
  home.username = "vscode";

  targets.genericLinux.enable = true;

  nix.package = pkgs.nix;

  programs.zsh.initExtra = mkBefore ''
    # Check if user environment variables are set because containers doesn't set
    # them by default and Home Manager needs them to work properly
    export USER=''${USER:-$(whoami)}
  '';
}
