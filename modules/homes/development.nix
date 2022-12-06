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
    pkgs.aria
    pkgs.cloudflared
    pkgs.github-cli
    pkgs.glab
    pkgs.bitwarden-cli
    pkgs.gnumake
    pkgs.graphviz
    pkgs.pprof
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
