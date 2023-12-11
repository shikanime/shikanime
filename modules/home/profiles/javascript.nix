{ pkgs, ... }:

{
  home.packages = [
    pkgs.nodejs
    pkgs.deno
    pkgs.yarn
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "node"
    "deno"
    "npm"
    "yarn"
  ];

  programs.neovim.withNodeJs = true;
}
