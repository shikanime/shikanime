{ config, ... }:

{
  programs.go = {
    enable = true;
    goPath = "${config.xdg.dataHome}/go";
  };

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];
}
