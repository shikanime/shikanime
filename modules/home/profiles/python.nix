{ pkgs, lib, ... }:

with lib;

{
  home.packages = [
    pkgs.poetry
  ];

  programs.neovim = {
    withPython3 = true;
    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
        python
      ]))
    ];
  };

  programs.zsh.oh-my-zsh.plugins = [
    "python"
    "poetry"
  ];
}
