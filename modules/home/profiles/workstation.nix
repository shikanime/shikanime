{ config, pkgs, lib, ... }:

with lib;

{
  xdg.enable = true;

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.packages = [
    pkgs.cachix
    pkgs.gnupatch
    pkgs.gnumake
    pkgs.gnused
    pkgs.gnugrep
    pkgs.less
    pkgs.zip
    pkgs.unzip
    pkgs.which
    pkgs.bzip2
    pkgs.graphviz
    pkgs.rsync
    pkgs.curl
    pkgs.wget
    pkgs.watch
    pkgs.pprof
  ];

  programs.mise.enable = true;

  xdg.configFile."direnv/lib/hm-mise.sh".text = ''
    eval "$(${config.programs.mise.package}/bin/mise direnv activate)"
  '';

  programs.dircolors.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "sudo"
        "docker"
      ];
    };
  };

  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config.global.load_dotenv = true;
  };

  programs.jq.enable = true;

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
    addKeysToAgent = "yes";
  };
}
