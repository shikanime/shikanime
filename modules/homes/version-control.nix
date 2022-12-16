{ pkgs, config, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.darcs
    pkgs.github-cli
    pkgs.subversion
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "git"
  ];

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
    includes = [
      {
        condition = "gitdir:${config.home.homeDirectory}/";
        contents = {
          core.editor = "${pkgs.neovim}/bin/nvim";
          commit.gpgSign = true;
          tag.gpgSign = true;
        };
      }
    ];
    extraConfig = {
      pull.rebase = true;
      rebase.autostash = true;
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
    };
  };
}
