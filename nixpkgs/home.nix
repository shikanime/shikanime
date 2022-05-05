{ pkgs ? import <nixpkgs> { }, ... }:

{
  # Enable XDG base directories.
  xdg.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Session configuration
  home.sessionVariables.EDITOR = "vim";

  # Local programs
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Core global utilitary packages
  home.packages = [
    pkgs.nixpkgs-fmt
    pkgs.gnumake
    pkgs.gcc
    pkgs.wget
    pkgs.curl
    pkgs.unzip
    pkgs.zip
    pkgs.darcs
    pkgs.nodejs
    pkgs.deno
    pkgs.rustup
    pkgs.minikube
    pkgs.skaffold
    pkgs.google-cloud-sdk
    pkgs.azure-cli
    pkgs.aws
    pkgs.kubectl
    pkgs.istioctl
    pkgs.kn
    pkgs.cloudflared
    pkgs.github-cli
  ] ++ pkgs.lib.optionals pkgs.hostPlatform.isLinux [
    pkgs.binutils
  ];

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

  programs.vim.enable = true;

  programs.jq.enable = true;

  programs.dircolors.enable = true;

  programs.bash.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.java.enable = true;

  programs.go.enable = true;

  programs.opam = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

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
      "coopelec.ssh.dev.azure.com" = {
        hostname = "ssh.dev.azure.com";
        identityFile = "~/.ssh/coopelec";
      };
      "lvmh.ssh.dev.azure.com" = {
        hostname = "ssh.dev.azure.com";
        identityFile = "~/.ssh/lvmh";
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

  services.syncthing = pkgs.lib.mkIf pkgs.hostPlatform.isLinux {
    enable = true;
  };
}
