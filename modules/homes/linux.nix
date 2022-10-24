{ pkgs, config, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.gcc
    pkgs.binutils
    pkgs.inotify-tools
    pkgs.cmake
  ];

  home.sessionVariables = {
    CMAKE_C_COMPILER = "${pkgs.gcc}/bin/gcc";
    CMAKE_CXX_COMPILER = "${pkgs.gcc}/bin/g++";
  };
}
