{ config, ... }:

{
  imports = [
    ./asdf.nix
  ];

  home.sessionVariables = {
    GOPATH = "${config.xdg.configHome}/go";
    GOBIN = "${config.home.homeDirectory}/.local/bin";
  };

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];
}
