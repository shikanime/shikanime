{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pkgs.texlive.combined.scheme-full
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      latex
    ]))
  ];
}
