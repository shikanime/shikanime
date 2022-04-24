{ pkgs ? import <nixpkgs> { }, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Session configuration
  home.sessionVariables.EDITOR = "vim";

  # Local programs
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Core global utilitary packages
  home.packages = [ pkgs.nixpkgs-fmt ];

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
