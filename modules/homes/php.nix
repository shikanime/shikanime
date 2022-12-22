{ pkgs, ... }:

{
  home.packages = [
    pkgs.php
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      php
      phpdoc
    ]))
  ];
}
