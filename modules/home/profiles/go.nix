{
  home.sessionPath = [
    "${config.xdg.dataHome}/go/bin"
  ];

  home.sessionVariables.GOPATH = "${config.xdg.dataHome}/go";

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];
}
