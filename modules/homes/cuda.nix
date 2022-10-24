{ pkgs, config, lib, ... }:

{
  home.sessionVariables = {
    CUDA_TOOLKIT_ROOT_DIR = "${pkgs.cudaPackages.cudatoolkit}";
    CUDNN_ROOT_DIR = "${pkgs.cudaPackages.cudnn}";
    LD_LIBRARY_PATH = lib.concatStringsSep ":" [
      "/usr/lib/wsl/lib"
      "/run/opengl-drivers/lib"
      "/run/opengl-drivers-32/lib"
    ];
  };
}
