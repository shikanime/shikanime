{ pkgs ? import <nixpkgs> { }, config, ... }:

{
  # Local programs
  home.sessionPath = [
    "${config.home.homeDirectory}/.mix/escripts"
  ];

  # Core global utilitary packages
  home.packages = [
    pkgs.sqlfluff
    pkgs.htop
    pkgs.openssl
    pkgs.file
    pkgs.wget
    pkgs.curl
    pkgs.darcs
    pkgs.minikube
    pkgs.google-cloud-sdk
    pkgs.azure-cli
    pkgs.aws
    pkgs.kubectl
    pkgs.github-cli
    pkgs.rustup
    pkgs.nodejs
    pkgs.python3
    pkgs.deno
    pkgs.poetry
    pkgs.php
    pkgs.gcc
    pkgs.binutils
    pkgs.gnumake
    pkgs.dotnet-sdk
    pkgs.terraform
    pkgs.bitwarden-cli
    pkgs.nixpkgs-fmt
    pkgs.cachix
  ];

  programs.go = {
    enable = true;
    goPath = "${config.xdg.dataHome}/go";
  };

  programs.opam = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.jq.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;
  };

  programs.zsh.oh-my-zsh.plugins = [
    "git"
    "gcloud"
    "aws"
    "python"
    "docker"
    "kubectl"
    "rust"
    "node"
    "minikube"
    "golang"
    "yarn"
    "vim-interaction"
  ];

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "coopelec.ssh.dev.azure.com" = {
        hostname = "ssh.dev.azure.com";
        identityFile = "~/.ssh/coopelec_rsa";
      };
      "celine.ssh.dev.azure.com" = {
        hostname = "ssh.dev.azure.com";
        identityFile = "~/.ssh/celine_ed25519";
      };
      "gcmd.birdz.com" = {
        hostname = "gcmd.birdz.com";
        identityFile = "~/.ssh/birdz_ed25519";
      };
      "sfeir.gitlab.com" = {
        hostname = "gitlab.com";
        identityFile = "~/.ssh/sfeir_ed25519";
      };
      "sfeir.bitbucket.org" = {
        hostname = "bitbucket.org";
        identityFile = "~/.ssh/sfeir_ed25519";
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

    ignores = [
      "*~"
      ".fuse_hidden*"
      ".directory"
      ".Trash-*"
      ".nfs*"
    ];

    lfs.enable = true;

    signing = {
      key = "B9443725856FF9EB";
      signByDefault = true;
    };

    includes = [
      {
        condition = "gitdir:${config.home.homeDirectory}/Source/Repos/sfeir/";
        contents = {
          user = {
            name = "William Phetsinorath";
            email = "phetsinorath.w@sfeir.com";
            signingKey = "9A31DF925449E15A";
          };
          commit.gpgSign = true;
        };
      }
    ];

    extraConfig = {
      core.editor = "${pkgs.neovim}/bin/nvim";
      pull.rebase = true;
      rebase.autostash = true;
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      credential."https://dev.azure.com".useHttpPath = true;
      credential."https://source.developers.google.com".helper = "${pkgs.google-cloud-sdk}/bin/git-credential-gcloud.sh";
    };
  };
}
