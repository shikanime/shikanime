{ pkgs, config, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.snowsql
    pkgs.sqlfluff
    pkgs.htop
    pkgs.openssl
    pkgs.file
    pkgs.wget
    pkgs.curl
    pkgs.darcs
    pkgs.cloudflared
    pkgs.minikube
    pkgs.google-cloud-sdk
    pkgs.azure-cli
    pkgs.aws
    pkgs.kubectl
    pkgs.github-cli
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
    extraConfig = ''
      IdentitiesOnly yes
      HostKeyAlgorithms +ssh-rsa
      PubkeyAcceptedKeyTypes +ssh-rsa
    '';
  };

  programs.mercurial.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
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
