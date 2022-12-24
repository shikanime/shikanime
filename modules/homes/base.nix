{ pkgs, config, lib, ... }:

with lib;

{
  # Set target to Flake's Nix
  nix.package = pkgs.nix;

  home.packages = [
    pkgs.watch
    pkgs.openssl
    pkgs.file
    pkgs.wget
    pkgs.curl
    pkgs.gnumake
    pkgs.graphviz
    pkgs.pprof
  ];

  # Enable experimental features so we can access flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Add personal caching server
  nix.settings = {
    trusted-substituters = [
      "https://shikanime.cachix.org"
    ];
    trusted-public-keys = [
      "shikanime.cachix.org-1:OrpjVTH6RzYf2R97IqcTWdLRejF6+XbpFNNZJxKG8Ts="
    ];
  };

  # Allow unfree software such as Cloudflared or CUDA
  nixpkgs.config.allowUnfree = true;

  programs.dircolors.enable = true;

  programs.bash.enable = true;

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
      noremap n j|noremap <C-w>n <C-w>j|noremap <C-w><C-n> <C-w>j
      noremap e k|noremap <C-w>e <C-w>k|noremap <C-w><C-e> <C-w>k
      noremap s h
      noremap t l

      noremap f e
      noremap k n
      noremap K N
      noremap U <C-r>
    '';
  };

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
    extraOptionOverrides = {
      IgnoreUnknown = lib.concatStringsSep "," [
        "UseKeychain"
        "PubkeyAcceptedAlgorithms"
      ];
    };
  };

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
