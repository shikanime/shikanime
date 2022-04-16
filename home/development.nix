{ pkgs ? import <nixpkgs> { }, ... }:

let
  pythonPackages = pkgs.python3.withPackages
    (pypkgs: with pypkgs; [ pip pipx black flake8 autopep8 ]);
in
{
  home.packages = [
    pkgs.skaffold
    pkgs.kompose
    pkgs.google-cloud-sdk
    pkgs.azure-cli
    pkgs.aws
    pkgs.docker
    pkgs.minikube
    pkgs.kubectl
    pkgs.istioctl
    pkgs.kn
    pkgs.cloudflared
    pkgs.terraform
    pkgs.github-cli
    pkgs.gnumake
    pkgs.cmake
    pkgs.darcs
    pkgs.nixpkgs-fmt
    pkgs.clang
    pkgs.clang-tools
    pkgs.php
    pkgs.ruby
    pkgs.rustup
    pkgs.poetry
    pkgs.elixir
    pkgs.erlang
    pkgs.rebar3
    pkgs.nodejs
    pkgs.deno
    pkgs.yarn
    pkgs.go
    pythonPackages
    pkgs.texlive.combined.scheme-full
  ];

  programs.java.enable = true;

  programs.go.enable = true;

  programs.opam = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };

  programs.zsh = {
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
        "node"
        "minikube"
        "golang"
        "sudo"
        "yarn"
        "vim-interaction"
      ];
    };
  };

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "gitlab.com" = {
        hostname = "gitlab.com";
        identityFile = "~/.ssh/gitlab";
        identitiesOnly = true;
      };
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };
      "coopelec.ssh.dev.azure.com" = {
        hostname = "ssh.dev.azure.com";
        identityFile = "~/.ssh/coopelec";
        identitiesOnly = true;
      };
      "lvmh-celine.ssh.dev.azure.com" = {
        hostname = "ssh.dev.azure.com";
        identityFile = "~/.ssh/lvmh-celine";
        identitiesOnly = true;
      };
      "gcmd.birdz.com" = {
        hostname = "gcmd.birdz.com";
        identityFile = "~/.ssh/birdz";
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

    aliases = {
      adog = "log --all --decorate --oneline --graph";
      am = "commit --amend";
      pouf = "push --force-with-lease";
    };
    ignores = [ "*~" ".fuse_hidden*" ".directory" ".Trash-*" ".nfs*" ];

    lfs.enable = true;

    extraConfig = {
      core.editor = "vim";
      color.ui = "auto";
      pull.rebase = true;
      rebase.autostash = true;
      init.defaultBranch = "main";
      credential."https://dev.azure.com".useHttpPath = true;
      credential.helper = "store";
    };
  };
}
