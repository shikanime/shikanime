{ pkgs, ... }:

{
  home.packages = [
    pkgs.texlive.combined.scheme-basic
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      latex
    ]))
  ];
}
