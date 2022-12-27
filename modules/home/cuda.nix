{ pkgs, lib, ... }:

with lib;

{
  home.sessionVariables = {
    CUDA_TOOLKIT_ROOT_DIR = "${pkgs.cudaPackages.cudatoolkit}";
    CUDNN_ROOT_DIR = "${pkgs.cudaPackages.cudnn}";
    LD_LIBRARY_PATH = concatStringsSep ":" [
      "/usr/lib/wsl/lib"
      "/run/opengl-drivers/lib"
      "/run/opengl-drivers-32/lib"
    ];
  };

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      cuda
    ]))
  ];
}
