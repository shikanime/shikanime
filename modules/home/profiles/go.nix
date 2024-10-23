{ config, ... }:

{
  programs.go = {
    enable = true;
    goPath = "${config.xdg.configHome}/go";
    goBin = "${config.home.homeDirectory}/.local/bin";
  };

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];
}
