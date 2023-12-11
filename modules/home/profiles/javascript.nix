{ pkgs, ... }:

{
  home.packages = [
    pkgs.nodejs
    pkgs.deno
    pkgs.bun
    pkgs.yarn
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "node"
    "deno"
    "bun"
    "npm"
    "yarn"
  ];

  programs.neovim.withNodeJs = true;
}
