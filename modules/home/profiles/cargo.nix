{
  home.sessionPath = [
    "${config.xdg.dataHome}/cargo/bin"
  ];

  home.sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";

  programs.zsh.oh-my-zsh.plugins = [
    "rust"
  ];
}
