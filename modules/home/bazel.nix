{ pkgs, ... }:

{
  home.packages = [
    pkgs.bazelisk
    pkgs.bazel-buildtools
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "bazel"
  ];
}
