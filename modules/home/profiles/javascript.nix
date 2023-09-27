{ pkgs, ... }:

{
  home.packages = [
    pkgs.nodejs
    pkgs.deno
    pkgs.yarn
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "deno"
    "node"
    "npm"
    "yarn"
  ];

  programs.neovim.withNodeJs = true;
}
