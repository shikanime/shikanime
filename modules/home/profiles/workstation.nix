{ config, pkgs, lib, ... }:

with lib;

{
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
    pkgs.nixpkgs-fmt
  ];

  programs.dircolors.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "vim-interaction"
        "sudo"
        "docker"
      ];
    };
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config = {
        show_banner: false,
      }
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };

  programs.jq.enable = true;

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        identityFile = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
      };
      "gitlab.com" = {
        identityFile = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
      };
    };
    extraConfig = ''
      AddKeysToAgent yes
    '' + optionalString pkgs.stdenv.hostPlatform.isDarwin ''
      UseKeychain yes
    '';
  };
}
