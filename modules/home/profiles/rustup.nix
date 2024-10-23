{ config, pkgs, ... }:

{
  home.sessionPath = [
    "${config.xdg.configHome}/cargo/bin"
  ];

  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.configHome}/cargo";
    RUSTUP_HOME = "${config.xdg.configHome}/rustup";
  };

  home.packages = [
    pkgs.rustup
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "rust"
  ];
}
