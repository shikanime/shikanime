{ pkgs, ... }:

{
  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      php
      phpdoc
    ]))
  ];
}
