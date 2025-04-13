{ config, lib, ... }:

with lib;

{
  imports = [
    ../../../../modules/home/base.nix
    ../../../../modules/home/beam.nix
    ../../../../modules/home/cloud.nix
    ../../../../modules/home/desktop.nix
    ../../../../modules/home/starship.nix
    ../../../../modules/home/go.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/java.nix
    ../../../../modules/home/javascript.nix
    ../../../../modules/home/python.nix
    ../../../../modules/home/rustup.nix
    ../../../../modules/home/unix.nix
    ../../../../modules/home/vcs.nix
    ../../../../modules/home/workstation.nix
  ];

  programs.fish.interactiveShellInit = mkAfter ''
    if test -d "${config.home.homeDirectory}/.rd"
      set -gx PATH "${config.home.homeDirectory}/.rd/bin" $PATH
    end
    if test -e "${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
        set -gx SSH_AUTH_SOCK "${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
    end
  '';
}
