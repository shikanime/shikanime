{ pkgs ? import <nixpkgs> { }, lib, ... }:

{
  # Create user accounts
  users.users.devas = {
    isNormalUser = true;
    home = "/home/devas";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = "$6$YS5jCyZU2Z6i05wm$jFsx9fnINawEk2Vd5uZBdR71sOBHHgANUEBsp93fG3scp2uui3kYhzXh9c4eC4ZdHKq48//IWE00JwZ.ez.lg.";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7pi5OYqzuMkTymIbJUJteIU3dz+OgduiF5O9cA+B7u devas@ishtar"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFChPMDHee+8F8tuchk8nLqdzVj1SOfLFv70NH95K6Yf williamphetsinorath@altashar"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.devas = {
      # Enable XDG base directories
      xdg.enable = true;

      # Let Home Manager install and manage itself
      programs.home-manager.enable = true;

      # Session configuration
      home.sessionVariables = {
        EDITOR = "vim";
        LD_LIBRARY_PATH = lib.makeLibraryPath [
          pkgs.stdenv.cc.cc.lib
        ];
      };

      # Local programs
      home.sessionPath = [
        "$HOME/.local/bin"
      ];

      # Core global utilitary packages
      home.packages =
        let
          pythonEnv = pkgs.python3.withPackages (pypkgs: [
            pypkgs.pip
            pypkgs.pipx
            pypkgs.black
          ]);
        in
        [
          pkgs.wget
          pkgs.curl
          pkgs.darcs
          pkgs.minikube
          pkgs.skaffold
          pkgs.kompose
          pkgs.google-cloud-sdk
          pkgs.azure-cli
          pkgs.aws
          pkgs.kubectl
          pkgs.istioctl
          pkgs.kn
          pkgs.cloudflared
          pkgs.github-cli
          pkgs.nixpkgs-fmt
          pkgs.cmake
          pkgs.gnumake
          pkgs.gcc
          pkgs.binutils
          pkgs.clang-tools
          pkgs.rustup
          pkgs.yarn
          pkgs.nodejs
          pkgs.deno
          pkgs.poetry
          pkgs.terraform
          pkgs.php
          pkgs.ruby
          pkgs.elixir
          pkgs.erlang
          pkgs.rebar3
          pkgs.tectonic
          pkgs.texlive.combined.scheme-basic
          pythonEnv
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

      services.gpg-agent = {
        enable = true;
        enableSshSupport = true;
      };

      services.syncthing = {
        enable = true;
      };
    };
  };
}
