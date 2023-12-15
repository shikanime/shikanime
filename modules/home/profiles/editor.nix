{ pkgs, ... }:

let
  treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
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
  ]);
in
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
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.fzf-vim
      pkgs.vimPlugins.catppuccin-nvim
      treesitter
    ];
    extraLuaConfig = ''
      vim.g.catppuccin_flavour = "latte"
      vim.g.airline_theme = "catppuccin"
      require("catppuccin").setup({
        integrations = {
          gitgutter = true,
          treesitter = true,
          telescope = {
            enabled = true,
          }
        }
      })
      vim.cmd [[colorscheme catppuccin]]
    '';
    extraConfig = ''
      set number relativenumber
    '';
  };
}
