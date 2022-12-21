{ pkgs, config, lib, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.cmake
    pkgs.ccache
    pkgs.ninja
  ];
}
