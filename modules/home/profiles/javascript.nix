{
  programs.zsh.oh-my-zsh.plugins = [
    "node"
    "deno"
    "bun"
    "npm"
    "yarn"
  ];

  programs.neovim.withNodeJs = true;
}
