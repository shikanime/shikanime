{ lib, config, pkgs ? import <nixpkgs> { }, ... }:

let
  devPackages = [
    pkgs.darcs
    pkgs.nixfmt
    pkgs.rustup
    pkgs.poetry
    pkgs.python3Packages.black
    pkgs.python3Packages.flake8
    pkgs.python3Packages.autopep8
    pkgs.nodePackages.esy
    pkgs.nodePackages.eslint
    pkgs.nodePackages.stylelint
    pkgs.nodePackages.htmlhint
    pkgs.nodePackages.jshint
    pkgs.nodePackages.prettier
  ];

  cloudPackages = [
    pkgs.google-cloud-sdk
    pkgs.azure-cli
    pkgs.aws
    pkgs.kubectl
    pkgs.minikube
    pkgs.cloudflared
    pkgs.terraform
    pkgs.github-cli
    pkgs.podman
  ];

  utilityPackages = [
    pkgs.daemonize
    pkgs.openssh
    pkgs.unzip
    pkgs.htop
    pkgs.yq
    pkgs.zip
    pkgs.syncthing
  ] ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    pkgs.inotify-tools
    pkgs.usbutils
  ];
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Session configuration
  home.sessionVariables.EDITOR = "vim";

  # Core global utilitary packages
  home.packages = devPackages ++ cloudPackages ++ utilityPackages;

  home.file.".editorconfig".text = ''
    # top-most EditorConfig file
    root = true

    # Unix-style newlines with a newline ending every file
    [*]
    end_of_line = lf
    insert_final_newline = true

    # Matches multiple files with brace expansion notation
    # Set default charset
    [*.{js,py}]
    charset = utf-8

    # 4 space indentation
    [*.py]
    indent_style = space
    indent_size = 4

    # Tab indentation (no size specified)
    [Makefile]
    indent_style = tab
  '';

  programs.java.enable = true;

  # TODO: find a way to add gopls, gopkgs, go-outline, dlv, dlv-dap and staticcheck.
  programs.go.enable = true;

  programs.vim.enable = true;

  programs.opam = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.jq.enable = true;

  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "ubuntu"
        "gcloud"
        "aws"
        "python"
        "docker"
        "kubectl"
        "rust"
        "rustup"
        "node"
        "minikube"
        "golang"
        "sudo"
        "vim-interaction"
      ];
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    newSession = true;
  };

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "gitlab.com" = {
        hostname = "gitlab.com";
        identityFile = "${config.home.homeDirectory}/.ssh/gitlab";
        identitiesOnly = true;
      };
      "github.com" = {
        hostname = "github.com";
        identityFile = "${config.home.homeDirectory}/.ssh/github";
        identitiesOnly = true;
      };
      "ssh.dev.azure.com" = {
        hostname = "ssh.dev.azure.com";
        identityFile = "${config.home.homeDirectory}/.ssh/azure";
        identitiesOnly = true;
      };
      "gcmd.birdz.com" = {
        hostname = "gcmd.birdz.com";
        identityFile = "${config.home.homeDirectory}/.ssh/birdz";
        identitiesOnly = true;
      };
    };
    extraConfig = ''
      HostKeyAlgorithms +ssh-rsa
      PubkeyAcceptedKeyTypes +ssh-rsa
    '';
  };

  programs.mercurial = {
    enable = true;
    userName = "Shikanime Deva";
    userEmail = "deva.shikanime@protonmail.com";
  };

  programs.git = {
    enable = true;
    userName = "Shikanime Deva";
    userEmail = "deva.shikanime@protonmail.com";

    aliases.adog = "log --all --decorate --oneline --graph";
    ignores = [ "*~" ".fuse_hidden*" ".directory" ".Trash-*" ".nfs*" ];

    lfs.enable = true;

    extraConfig = {
      core.editor = "vim";
      color.ui = "auto";
      pull = {
        ff = "only";
        rebase = true;
      };
      rebase.autoStash = true;
      init.defaultBranch = "main";
      credential."https://dev.azure.com".useHttpPath = true;
    };
  };

  programs.mpv.enable = true;

  services.gpg-agent = {
    enable = pkgs.stdenv.hostPlatform.isLinux;
    enableSshSupport = true;
  };

  services.syncthing.enable = pkgs.stdenv.hostPlatform.isLinux;
}
