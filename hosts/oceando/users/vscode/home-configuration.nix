{ lib, ... }:

with lib;

{
  imports = [
    ../../../../modules/home/base.nix
    ../../../../modules/home/cloud.nix
    ../../../../modules/home/go.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/javascript.nix
    ../../../../modules/home/python.nix
    ../../../../modules/home/rustup.nix
    ../../../../modules/home/starship.nix
    ../../../../modules/home/unix.nix
    ../../../../modules/home/vcs.nix
    ../../../../modules/home/workstation.nix
  ];

  programs.bash.initExtra = mkAfter ''
    # Check if user environment variables are set because containers doesn't set
    # them by default and Home Manager needs them to work properly
    [ -n "$USER" ] || export USER=$(whoami)
  '';
}
