{ pkgs, lib, ... }:

with lib;

let
  initExtra = mkAfter ''
    # Check if user environment variables are set because containers doesn't set
    # them by default and Home Manager needs them to work properly
    export USER=''${USER:-$(whoami)}
  '';
in
{
  imports = [
    ../identities/shikanime.nix
    ../profiles/base.nix
    ../profiles/editor.nix
    ../profiles/workstation.nix
    ../profiles/xdg.nix
    ../profiles/vcs.nix
    ../profiles/cloud.nix
    ../profiles/javascript.nix
    ../profiles/python.nix
    ../profiles/native.nix
    ../profiles/beam.nix
    ../profiles/go.nix
  ];

  home = {
    homeDirectory = "/home/vscode";
    username = "vscode";
  };

  targets.genericLinux.enable = true;

  nix.package = pkgs.nix;

  programs.zsh = { inherit initExtra; };
  programs.bash = { inherit initExtra; };

  home.packages = [ pkgs.iputils ];
}
