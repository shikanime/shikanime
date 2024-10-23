{ config, ... }:

{
  home.sessionPath = [
    "${config.xdg.configHome}/cargo/bin"
  ];

  home.packages = [
    pkgst.rustup
  ];

  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.configHome}/cargo";
    RUSTUP_HOME = "${config.xdg.configHome}/rustup";
  };

  programs.zsh.oh-my-zsh.plugins = [
    "rust"
  ];
}
