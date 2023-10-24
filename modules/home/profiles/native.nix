{ pkgs, ... }:

{
  programs.zsh.oh-my-zsh.plugins = [
    "rust"
  ];

  home.packages = [
    pkgs.rustup
    pkgs.cmake
    pkgs.meson
    pkgs.ninja
    pkgs.ccache
    pkgs.gdb
    pkgs.lldb
  ];
}
