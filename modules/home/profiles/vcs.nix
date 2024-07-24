{ config, pkgs, ... }:

{
  programs.zsh.oh-my-zsh.plugins = [
    "git"
  ];

  programs.mercurial.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    signing.signByDefault = true;
    aliases = {
      filing = "commit --amend --signoff --no-edit --reset-author";
      refiling = "rebase --exec 'git filing'";
      adog = "log --all --decorate --oneline --graph";
      pouf = "push --force-with-lease";
      poi = "commit --amend --no-edit";
      tape = "push --mirror";
    };
    ignores = [
      # Backup files
      "*~"
      # Temporary files which can be created if a process still has a handle open of a deleted file
      ".fuse_hidden*"
      # KDE directory preferences
      ".directory"
      # Linux trash folder which might appear on any partition or disk
      ".Trash-*"
      # .nfs files are created when an open file is removed but is still being accessed
      ".nfs*"
      # Windows thumbnail cache files
      "Thumbs.db"
      "Thumbs.db:encryptable"
      "ehthumbs.db"
      "ehthumbs_vista.db"
      # Dump file
      "*.stackdump"
      # Folder config file
      "[Dd]esktop.ini"
      # Recycle Bin used on file shares
      "$RECYCLE.BIN/"
      # Windows Installer files
      "*.cab"
      "*.msi"
      "*.msix"
      "*.msm"
      "*.msp"
      # Windows shortcuts
      "* .lnk"
      # Darwin Finder files
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      # Icon must end with two \r
      "Icon"
      # Thumbnails
      "._*"
      # Files that might appear in the root of a volume
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"
      # Directories potentially created on remote AFP share
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"
      # Git
      ".git"
    ];
    extraConfig = {
      pull.rebase = true;
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      advice.skippedCherryPicks = false;
      rebase = {
        autostash = true;
        updateRefs = true;
      };
    };
  };

  programs.sapling = {
    enable = true;
    extraConfig = {
      ui."ignore.git-config" = "${config.home.homeDirectory}/.config/git/ignore";
      merge-tools = {
        "nvim.args" = "-d $local $other $base -c 'redraw | echomsg \"hg merge conflict, type \":cq\" to abort vimdiff\"'";
        "nvim.priority" = 10;
      };
      hooks = {
        post-init = "git init --separate-git-dir .sl/store/git .";
        post-clone = "git init --separate-git-dir .sl/store/git .";
        txclose = "git update-ref HEAD `sl whereami` && git read-tree HEAD";
        update = "git update-ref HEAD $HG_PARENT1 && git read-tree HEAD";
      };
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      core.excludesfile = "${config.home.homeDirectory}/.config/git/ignore";
      ui.default-command = "log";
    };
  };
}
