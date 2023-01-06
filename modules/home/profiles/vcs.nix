{ pkgs, config, ... }:

{
  programs.zsh.oh-my-zsh.plugins = [
    "git"
  ];

  programs.mercurial = {
    enable = true;
    userName = "William Phetsinorath";
    userEmail = "william.phetsinorath@shikanime.studio";
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "William Phetsinorath";
    userEmail = "william.phetsinorath@shikanime.studio";
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
