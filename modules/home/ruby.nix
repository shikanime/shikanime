{ pkgs, ... }:

{
  home.packages = [
    pkgs.ruby
    pkgs.rubocop
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "ruby"
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      ruby
    ]))
  ];
}