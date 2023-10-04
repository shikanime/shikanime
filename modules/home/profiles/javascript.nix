{ pkgs, ... }:

{
  home.packages = [
    pkgs.nodejs
    pkgs.yarn
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "node"
    "npm"
    "yarn"
  ];

  programs.neovim.withNodeJs = true;
}
