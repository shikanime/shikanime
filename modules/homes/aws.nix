{ pkgs, config, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.aws
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "aws"
  ];
}
