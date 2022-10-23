{ pkgs, ... }:

{
  programs.java.enable = true;

  home.packages = [ pkgs.gradle ];

  programs.zsh.oh-my-zsh.plugins = [
    "gradle"
  ];
}
