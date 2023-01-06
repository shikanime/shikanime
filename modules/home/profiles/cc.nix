{ pkgs, lib, ... }:

with lib;

{
  programs.zsh.oh-my-zsh.plugins = [
    "bazel"
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      c
      cpp
      cmake
      ninja
      llvm
      lua
      cuda
    ]))
  ];
}
