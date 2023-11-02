{ pkgs, ... }:

{
  programs.zsh.oh-my-zsh.plugins = [
    "rust"
  ];

  home.packages = [
    pkgs.rustup
    pkgs.cmake
    pkgs.meson
    pkgs.muon
    pkgs.ninja
    pkgs.ccache
    pkgs.gdb
    pkgs.lldb
    pkgs.clang-tools
  ];
}
