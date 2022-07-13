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

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
