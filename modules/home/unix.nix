{ pkgs, ... }:

{
  home.packages = [
    pkgs.bash-language-server
    pkgs.clang-tools
  ];
}
