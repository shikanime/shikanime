{ pkgs, ... }:

{
  programs.java.enable = true;

  home.packages = [
    pkgs.coursier
    pkgs.gradle
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "gradle"
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      java
      kotlin
    ]))
  ];
}
