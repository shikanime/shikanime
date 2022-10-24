{ pkgs, config, lib, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.clang
    pkgs.inotify-tools
    pkgs.cmake
  ];
}
