{ pkgs, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.cmake
    pkgs.ccache
    pkgs.ninja
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      c
      cpp
      cmake
      ninja
      llvm
      lua
    ]))
  ];
}
