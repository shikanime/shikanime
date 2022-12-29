{ pkgs, config, ... }:

{
  home.homeDirectory = "/home/devas";
  home.username = "devas";

  home.packages = [
    pkgs.gcc
  ];

  programs.zsh.initExtra = ''
    # Source Anaconda3 if it exists
    if [ -d ${config.xdg.dataHome}/anaconda3 ]; then
      source ${config.xdg.dataHome}/anaconda3/bin/activate
    fi
  '';
}
