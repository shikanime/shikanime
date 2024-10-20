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
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../profiles/vcs.nix
    ../profiles/cloud.nix
  ];

  targets.genericLinux.enable = true;

  nix.package = pkgs.nix;

  programs.zsh = { inherit initExtra; };
  programs.bash = { inherit initExtra; };

  home.packages = [ pkgs.iputils ];
}
