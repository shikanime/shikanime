{ pkgs, ... }:

{
  home.packages = [
    pkgs.nodejs
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "deno"
    "node"
    "npm"
    "yarn"
  ];

  programs.neovim.withNodeJs = true;
}
