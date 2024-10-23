{ pkgs, lib, ... }:

with lib;

{
  imports = [
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../profiles/vcs.nix
    ../profiles/cloud.nix
    ../profiles/javascript.nix
    ../profiles/python.nix
    ../profiles/rustup.nix
    ../profiles/beam.nix
    ../profiles/go.nix
  ];

  targets.genericLinux.enable = true;

  nix.package = pkgs.nix;

  programs.zsh.initExtra = mkAfter ''
    # Check if user environment variables are set because containers doesn't set
    # them by default and Home Manager needs them to work properly
    export USER=''${USER:-$(whoami)}
  '';

  home.packages = [ pkgs.iputils ];
}
