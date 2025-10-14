{ config, lib, ... }:

with lib;

{
  imports = [
    ../../../../modules/home/base.nix
    ../../../../modules/home/cloud.nix
    ../../../../modules/home/ghostty.nix
    ../../../../modules/home/starship.nix
    ../../../../modules/home/go.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/javascript.nix
    ../../../../modules/home/python.nix
    ../../../../modules/home/rustup.nix
    ../../../../modules/home/unix.nix
    ../../../../modules/home/vcs.nix
    ../../../../modules/home/workstation.nix
  ];

  programs.zsh = {
    enable = true;
    initContent = mkAfter ''
      if test -d "${config.home.homeDirectory}/.rd"; then
        export PATH="${config.home.homeDirectory}/.rd/bin:$PATH"
      fi
      if test -e "${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"; then
        export SSH_AUTH_SOCK="${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
      fi
    '';
  };
}
