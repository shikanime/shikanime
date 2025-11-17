{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.ghstack
    pkgs.sapling
    pkgs.tea
  ];

  programs = {
    git = {
      enable = true;
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
      settings = {
        alias = {
          adog = "log --all --decorate --oneline --graph";
          filing = "commit --amend --signoff --no-edit --reset-author";
          poi = "commit --amend --no-edit";
          pouf = "push --force-with-lease";
          refiling = "rebase --exec 'git filing'";
          tape = "push --mirror";
        };
        advice.skippedCherryPicks = false;
        core.editor = "${lib.getExe pkgs.helix}";
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        rebase = {
          autostash = true;
          updateRefs = true;
        };
      };
    };

    jujutsu = {
      enable = true;
      settings = {
        aliases = {
          ab = [ "absorb" ];
          ci = [ "commit" ];
          ds = [ "describe" ];
          sq = [ "squash" ];
        };
        git.private-commits = "description(glob:'secret:*')";
        templates = {
          commit_trailers = ''
            format_signed_off_by_trailer(self)
            ++ if(!trailers.contains_key("Change-Id"), format_gerrit_change_id_trailer(self))
          '';
          git_push_bookmark = "\"trunks/${config.home.username}/\" ++ change_id.short()";
        };
        merge-tools.trae = {
          merge-args = [
            "--wait"
            "--merge"
            "$left"
            "$right"
            "$base"
            "$output"
          ];
          merge-tool-edits-conflict-markers = true;
          conflict-marker-style = "git";
        };
        ui = {
          default-command = "log";
          merge-editor = ":builtin";
        };
      };
    };
  };
}
