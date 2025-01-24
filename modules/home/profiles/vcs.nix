{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.watchman
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "git"
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
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
      # Sapling
      ".sl"
      # Jujutsu
      ".jj"
    ];
    extraConfig = {
      core.editor = "code --wait";
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
      ui = {
        "editor" = "code --wait";
        "ignore.git-config" = "${config.home.homeDirectory}/.config/git/ignore";
      };
      merge-tools = {
        "code.args" = "--wait --merge $local $other $base $output";
        "code.priority" = 10;
      };
      diff-tools = {
        "code.args" = "--wait --diff $local $other";
        "code.gui" = true;
        "code.priority" = 10;
      };
      github.pr_workflow = "single";
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
    aliases = {
      ab =[ "absorb"];
      ci = ["commit"];
      sq = ["squash"];
    };
    fix.tools = {
      nixfmt-rfc-style = {
command = ["${pkgs.nixfmt-rfc-style}/bin/nixfmt-rfc-style"];
patterns = ["*.nix"];
      };
      prettier = {
command = ["${pkgs.nodePackages.prettier}/bin/prettier" "--write"];
patterns = ["*.cjs" "*.css" "*.html" "*.js" "*.json" "*.json5" "*.jsx" "*.md" "*.mdx" "*.mjs" "*.scss" "*.ts" "*.tsx" "*.vue" "*.yaml" "*.yml"];
    };
shfmt = {

command = ["${pkgs.shfmt}/bin/shfmt" "-s" "-w" "-i" "2"];
patterns = ["*.sh" "*.bash" "*.envrc" "*.envrc.*"];
};
taplo = {
command = ["${pkgs.taplo}/bin/taplo" "format"];
patterns = ["*.toml"];
    };
shellcheck = {
command = ["${pkgs.shellcheck}/bin/shellcheck"];
patterns = ["*.sh" "*.bash" "*.envrc" "*.envrc.*"];
   };
   statix = {
command = ["${pkgs.statix}/bin/statix-fix"];
patterns = ["*.nix"];
   };
   nufmt = {
    command = ["${pkgs.nufmt}/bin/nufmt"];
    patterns = ["*.nu"];
   };
   yamlfmt = {
    command = ["${pkgs.yamlfmt}/bin/yamlfmt"];
    patterns = ["*.yaml" "*.yml"];
   };
    };
    git = {
      private-commits = "description(glob:'secret:*')";
      push-branch-prefix = "trunks/shikanime/";
    };
  };
  };
}
