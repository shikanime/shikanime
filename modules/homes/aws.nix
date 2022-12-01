{ pkgs, config, ... }:

{
  # Core global utilitary packages
  home.packages = [
    pkgs.awscli2
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "aws"
  ];
}
