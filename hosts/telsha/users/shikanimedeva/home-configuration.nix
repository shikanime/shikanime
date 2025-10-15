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

  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.rd/bin"
    ];
    sessionVariables.SSH_AUTH_SOCK = "${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
  };

  programs.bash.enable = true;

  programs.docker-cli.settings = {
    credsStore = "osxkeychain";
    currentContext = "rancher-desktop";
  };

  programs.zsh.enable = true;
}
