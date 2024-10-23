{
  programs.zsh.oh-my-zsh.plugins = [
    "python"
    "poetry"
  ];

  home.packages = [
    pkgs.uv
  ];
}
