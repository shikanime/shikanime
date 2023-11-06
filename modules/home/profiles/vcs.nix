{ lib, pkgs, ... }:

with lib;

let
  iniFormat = pkgs.formats.ini { };
  userName = "William Phetsinorath";
  userEmail = "william.phetsinorath@shikanime.studio";
  signingKey = "EB584D3ACB58F471";
in
{
  home.packages = [
    pkgs.darcs
    pkgs.subversion
    pkgs.sapling
    pkgs.graphite-cli
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "git"
  ];

  programs.mercurial = {
    inherit userName userEmail;
    enable = true;
  };

  programs.git = {
    inherit userName userEmail;
    enable = true;
    lfs.enable = true;
    signing = {
      key = signingKey;
      signByDefault = true;
    };
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

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = userName;
        email = userEmail;
      };
    };
  };

  xdg.configFile = lib.attrsets.optionalAttrs pkgs.stdenv.isLinux {
    "sapling/sapling.conf".source = iniFormat.generate "sapling.conf" {
      ui.username = "${userName} <${userEmail}>";
      gpg.key = signingKey;
    };
  };

  home.file = lib.attrsets.optionalAttrs pkgs.stdenv.isDarwin {
    "Library/Preferences/sapling/sapling.conf".source = iniFormat.generate "sapling.conf" {
      ui.username = "${userName} <${userEmail}>";
      gpg.key = signingKey;
    };
  };
}
