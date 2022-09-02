{ pkgs, ... }:

{
  home.packages = [ pkgs.mono ];

  programs.zsh.oh-my-zsh.plugins = [
    "dotnet"
  ];
}
