{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    plugins = [
      pkgs.vimPlugins.lush-nvim
      pkgs.vimPlugins.vim-colemak
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
        jq
        markdown_inline
        regex
        vim
      ]))
    ];
    extraConfig = ''
      set number relativenumber
    '';
  };
}
