{
  config,
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.glab
    pkgs.watchman
  ];

  programs.git = {
    aliases = {
      adog = "log --all --decorate --oneline --graph";
      filing = "commit --amend --signoff --no-edit --reset-author";
      poi = "commit --amend --no-edit";
      pouf = "push --force-with-lease";
      refiling = "rebase --exec 'git filing'";
      tape = "push --mirror";
    };
    enable = true;
    extraConfig = {
      advice.skippedCherryPicks = false;
      core.editor = "${pkgs.helix}/bin/hx";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase = {
        autostash = true;
        updateRefs = true;
      };
    };
    ignores = [
      # Backup files
      "*~"
      # Darwin Finder files
      ".AppleDouble"
      ".DS_Store"
      ".LSOverride"
      # Directories potentially created on remote AFP share
      ".AppleDB"
      ".AppleDesktop"
      # Files that might appear in the root of a volume
      ".DocumentRevisions-V100"
      # KDE directory preferences
      ".directory"
      ".fseventsd"
      # Temporary files which can be created if a process still has a handle open of a deleted file
      ".fuse_hidden*"
      # Git
      ".git"
      # Jujutsu
      ".jj"
      # .nfs files are created when an open file is removed but is still being accessed
      ".nfs*"
      # Sapling
      ".sl"
      ".Spotlight-V100"
      ".TemporaryItems"
      # Linux trash folder which might appear on any partition or disk
      ".Trash-*"
      ".Trashes"
      ".VolumeIcon.icns"
      ".apdisk"
      ".com.apple.timemachine.donotpresent"
      # Thumbnails
      "._*"
      # Windows shortcuts
      "* .lnk"
      # Dump file
      "*.stackdump"
      # Windows Installer files
      "*.cab"
      "*.msi"
      "*.msix"
      "*.msm"
      "*.msp"
      # Recycle Bin used on file shares
      "$RECYCLE.BIN/"
      # Folder config file
      "[Dd]esktop.ini"
      "ehthumbs.db"
      "ehthumbs_vista.db"
      # Icon must end with two \r
      "Icon"
      "Network Trash Folder"
      "Temporary Items"
      "Thumbs.db"
      "Thumbs.db:encryptable"
    ];
    lfs.enable = true;
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      aliases = {
        ab = [ "absorb" ];
        ci = [ "commit" ];
        sq = [ "squash" ];
      };
      git = {
        private-commits = "description(glob:'secret:*')";
        push-bookmark-prefix = "trunks/shikanime/push-";
      };
      ui = {
        default-command = "log";
        merge-editor = ":builtin";
      };
    };
  };

  programs.sapling = {
    enable = true;
    extraConfig = {
      diff-tools = {
        "trae.args" = "--wait --diff $local $other";
        "trae.gui" = true;
        "trae.priority" = 20;
        "code.args" = "--wait --diff $local $other";
        "code.gui" = true;
        "code.priority" = 10;
      };
      github.pr_workflow = "single";
      merge-tools = {
        "trae.args" = "--wait --merge $local $other $base $output";
        "trae.priority" = 20;
        "code.args" = "--wait --merge $local $other $base $output";
        "code.priority" = 10;
      };
      ui = {
        editor = "${pkgs.helix}/bin/hx";
        "ignore.git-config" = "${config.home.homeDirectory}/.config/git/ignore";
      };
    };
  };
}
