{ pkgs, config, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.sqlfluff
    pkgs.htop
    pkgs.openssl
    pkgs.file
    pkgs.wget
    pkgs.curl
    pkgs.darcs
    pkgs.cloudflared
    pkgs.github-cli
    pkgs.bitwarden-cli
    pkgs.nixpkgs-fmt
    pkgs.cachix
    pkgs.gnumake
  ];

  programs.jq.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.zsh.oh-my-zsh.plugins = [
    "git"
    "vim-interaction"
  ];

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent yes
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
    };
  };
}
