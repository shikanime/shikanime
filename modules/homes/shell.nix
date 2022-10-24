{ pkgs, config, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.watch
    pkgs.htop
    pkgs.openssl
    pkgs.file
    pkgs.wget
    pkgs.curl
    pkgs.cloudflared
    pkgs.github-cli
    pkgs.bitwarden-cli
    pkgs.gnumake
  ];

  programs.jq.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.zsh.oh-my-zsh.plugins = [
    "vim-interaction"
  ];

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };
}
