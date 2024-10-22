{ config, ... }:

{
  home.sessionPath = [
    "${config.xdg.configHome}/cargo/bin"
  ];

  home.sessionVariables.CARGO_HOME = "${config.xdg.configHome}/cargo";

  programs.zsh.oh-my-zsh.plugins = [
    "rust"
  ];
}
