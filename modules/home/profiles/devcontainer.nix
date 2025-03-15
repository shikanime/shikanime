{ pkgs, lib, ... }:

with lib;

{
  home.packages = [ pkgs.iputils ];

  nix.package = pkgs.nix;

  programs.fish.interactiveShellInit = mkAfter ''
    # Check if user environment variables are set because containers doesn't set
    # them by default and Home Manager needs them to work properly
    export USER=''${USER:-$(whoami)}
  '';

  targets.genericLinux.enable = true;
}
