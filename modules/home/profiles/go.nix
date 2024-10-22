{ config, ... }:

{
  home.sessionPath = [
    "${config.xdg.configHome}/go/bin"
  ];

  home.sessionVariables.GOPATH = "${config.xdg.configHome}/go";

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];
}
