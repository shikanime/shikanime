{ pkgs, ... }:

{
  home.packages = [
    pkgs.gcc
    pkgs.binutils
    pkgs.gnumake
  ];
}
