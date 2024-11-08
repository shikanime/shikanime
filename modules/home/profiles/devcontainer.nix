{ pkgs, lib, ... }:

with lib;

{
  home.packages = [ pkgs.iputils ];

  nix.package = pkgs.nix;

  programs.zsh.initExtra = mkAfter ''
    # Check if user environment variables are set because containers doesn't set
    # them by default and Home Manager needs them to work properly
    export USER=''${USER:-$(whoami)}
  '';

  programs.k9s.enable = true;

  targets.genericLinux.enable = true;
}
