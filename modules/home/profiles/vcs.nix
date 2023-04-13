{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.darcs
    pkgs.subversion
  ];

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
    signing = {
      key = "025CF1599FA70256";
      signByDefault = true;
    };
    aliases = {
      adog = "log --all --decorate --oneline --graph";
      pouf = "push --force-with-lease";
      poi = "commit --amend --no-edit";
      tape = "push --all --follow-tags blackbox";
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
    ];
    extraConfig = {
      core.editor = "${pkgs.neovim}/bin/nvim";
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
}
