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
    pythonPackages
    pkgs.texlive.combined.scheme-full
  ] ++ pkgs.lib.optionals pkgs.hostPlatform.isLinux [
    pkgs.nerdctl
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
      "wonderland.local" = {
        hostname = "wonderland.local";
        identityFile = "~/.ssh/wonderland";
        user = "devas";
      };
      "gitlab.com" = {
        hostname = "gitlab.com";
        identityFile = "~/.ssh/gitlab";
      };
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/github";
      };
      "coopelec.ssh.dev.azure.com" = {
        hostname = "ssh.dev.azure.com";
        identityFile = "~/.ssh/coopelec";
      };
      "celine.lvmh.ssh.dev.azure.com" = {
        hostname = "ssh.dev.azure.com";
        identityFile = "~/.ssh/lvmh_celine";
      };
      "gcmd.birdz.com" = {
        hostname = "gcmd.birdz.com";
        identityFile = "~/.ssh/birdz";
      };
    };
    extraConfig = ''
      IdentitiesOnly yes
      HostKeyAlgorithms +ssh-rsa
      PubkeyAcceptedKeyTypes +ssh-rsa
    '';
  };

  programs.mercurial = {
    enable = true;
    userName = "Shikanime Deva";
    userEmail = "shikanime.deva@shikanime.studio";
  };

  programs.git = {
    enable = true;
    userName = "Shikanime Deva";
    userEmail = "shikanime.deva@shikanime.studio";

    aliases = {
      adog = "log --all --decorate --oneline --graph";
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
      credential."https://source.developers.google.com".helper = "gcloud.sh";
      credential.helper = "store";
      user.signingKey = "B9443725856FF9EB";
      commit.gpgSign = true;
    };
  };

  services.gpg-agent = pkgs.lib.mkIf pkgs.hostPlatform.isLinux {
    enable = true;
    enableSshSupport = true;
  };
}
