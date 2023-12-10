{ pkgs, lib, ... }:

with lib;

{
  imports = [
../../home/identities/sfeir.nix
../../home/profiles/base.nix
../../home/profiles/editor.nix
../../home/profiles/workstation.nix
../../home/profiles/xdg.nix
../../home/profiles/vcs.nix
../../home/profiles/cloud.nix
../../home/profiles/javascript.nix
../../home/profiles/java.nix
../../home/profiles/python.nix
../../home/profiles/native.nix
../../home/profiles/beam.nix
../../home/profiles/go.nix
  ];

  home.homeDirectory = "/home/vscode";
  home.username = "vscode";

  targets.genericLinux.enable = true;

  nix.package = pkgs.nix;

  programs.zsh.initExtra = mkBefore ''
    # Check if user environment variables are set because containers doesn't set
    # them by default and Home Manager needs them to work properly
    export USER=''${USER:-$(whoami)}
  '';

  home.packages = [ pkgs.iputils ];
}
