{ pkgs, ... }:

{
  home.packages = [
    pkgs.ruby
    pkgs.rubocop
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "ruby"
  ];
}
