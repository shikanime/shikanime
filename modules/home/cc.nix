{ pkgs, lib, ... }:

with lib;

{
  # Core global utilitary packages
  home.packages = optional pkgs.stdenv.hostPlatform.isLinux [
    pkgs.cudaPackages.cudatoolkit
    pkgs.cudaPackages.cudnn
    pkgs.cudaPackages.tensorrt
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
