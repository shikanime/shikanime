{ pkgs ? import <nixpkgs> { }, config, ... }:

{
  # Enable XDG base directories
  xdg.enable = true;

  programs.dircolors.enable = true;

  programs.bash.enable = true;

  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
