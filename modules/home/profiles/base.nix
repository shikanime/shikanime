{ pkgs, config, lib, ... }:

with lib;

{
  home.packages = [
    pkgs.git-branchless
    pkgs.gnupatch
    pkgs.gnumake
    pkgs.gnused
    pkgs.gnugrep
    pkgs.less
    pkgs.which
    pkgs.bzip2
    pkgs.graphviz
    pkgs.rsync
    pkgs.curl
    pkgs.wget
    pkgs.watch
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Enable experimental features so we can access flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree software such as Cloudflared or CUDA
  nixpkgs.config.allowUnfree = true;

  programs.dircolors.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "vim-interaction"
        "sudo"
        "docker"
      ];
    };
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
      let-env config = {
        show_banner: false
      }
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.jq.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = [
      pkgs.vimPlugins.lush-nvim
      pkgs.vimPlugins.vim-fugitive
      pkgs.vimPlugins.vim-gitgutter
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-commentary
      pkgs.vimPlugins.vim-surround
      pkgs.vimPlugins.vim-repeat
      pkgs.vimPlugins.nerdtree
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.fzf-vim
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
        json
        toml
        make
        markdown
        rst
        dot
        nix
        comment
        diff
        git_rebase
        gitattributes
        help
        jq
        markdown_inline
        regex
        vim
      ]))
    ];
    extraConfig = ''
      noremap d g
      noremap e k
      noremap f e
      noremap g t
      noremap i l
      noremap j y
      noremap k n
      noremap l u
      noremap n j
      noremap o p
      noremap p r
      noremap r s
      noremap s d
      noremap t f
      noremap u i
      noremap y o
      noremap D G
      noremap E K
      noremap F E
      noremap G T
      noremap I L
      noremap J Y
      noremap K N
      noremap L U
      noremap N J
      noremap O P
      noremap P R
      noremap R S
      noremap S D
      noremap T F
      noremap U I
      noremap Y O
      noremap dd gg
      noremap df ge
      set number relativenumber
    '';
  };

  programs.tmux.enable = true;

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "elkia.local" = {
        hostname = "elkia.local";
        user = "devas";
        forwardX11 = true;
        forwardX11Trusted = true;
        forwardAgent = true;
      };
      "elvengard.local" = {
        hostname = "elvengard.local";
        user = "devas";
        forwardX11 = true;
        forwardX11Trusted = true;
        forwardAgent = true;
      };
    };
    extraConfig = ''
      AddKeysToAgent yes
    '' + optionalString pkgs.stdenv.hostPlatform.isDarwin ''
      UseKeychain yes
    '';
    extraOptionOverrides = {
      IgnoreUnknown = concatStringsSep "," [
        "UseKeychain"
        "PubkeyAcceptedAlgorithms"
      ];
    };
  };

  # Enable Brew integration
  programs.zsh.initExtra = mkIf pkgs.stdenv.hostPlatform.isDarwin ''
    if which brew > /dev/null; then
      eval $(brew shellenv)
    fi
  '';

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release
  home.stateVersion = "22.11";
}
