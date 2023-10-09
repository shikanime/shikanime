{ pkgs, lib, ... }:

with lib;

{
  imports = [
    ../identities/sfeir.nix
    ../identities/paprec.nix
    ../identities/galec.nix
    ../identities/tagheuer.nix
    ../identities/totalenergies.nix
    ../identities/webedia.nix
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../profiles/xdg.nix
    ../profiles/vcs.nix
    ../profiles/cloud.nix
    ../profiles/javascript.nix
    ../profiles/python.nix
    ../profiles/rust.nix
    ../profiles/beam.nix
    ../profiles/go.nix
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
}
