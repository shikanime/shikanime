{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
      fish_config theme save "Catppuccin Latte"
    '';
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "fish";
          rev = "6a85af2ff722ad0f9fbc8424ea0a5c454661dfed";
          sha256 = "sha256-Oc0emnIUI4LV7QJLs4B2/FQtCFewRFVp7EDv8GawFsA=";
        };
      }
    ];
  };
}
