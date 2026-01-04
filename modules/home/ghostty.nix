{ lib, pkgs, ... }:

with lib;

{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.hostPlatform.isLinux then pkgs.ghostty else pkgs.ghostty-bin;
    themes = {
      "Catppuccin Frappe" = {
        palette = [
          "0=#51576d"
          "1=#e78284"
          "2=#a6d189"
          "3=#e5c890"
          "4=#8caaee"
          "5=#f4b8e4"
          "6=#81c8be"
          "7=#a5adce"
          "8=#626880"
          "9=#e78284"
          "10=#a6d189"
          "11=#e5c890"
          "12=#8caaee"
          "13=#f4b8e4"
          "14=#81c8be"
          "15=#b5bfe2"
        ];
        background = "303446";
        foreground = "c6d0f5";
        cursor-color = "f2d5cf";
        cursor-text = "232634";
        selection-background = "44495d";
        selection-foreground = "c6d0f5";
        split-divider-color = "414559";
      };
      "Catppuccin Latte" = {
        palette = [
          "0=#5c5f77"
          "1=#d20f39"
          "2=#40a02b"
          "3=#df8e1d"
          "4=#1e66f5"
          "5=#ea76cb"
          "6=#179299"
          "7=#acb0be"
          "8=#6c6f85"
          "9=#d20f39"
          "10=#40a02b"
          "11=#df8e1d"
          "12=#1e66f5"
          "13=#ea76cb"
          "14=#179299"
          "15=#bcc0cc"
        ];
        background = "eff1f5";
        foreground = "4c4f69";
        cursor-color = "dc8a78";
        selection-background = "d8dae1";
        selection-foreground = "4c4f69";
      };
    };
    settings = {
      theme = "dark:Catppuccin Frappe,light:Catppuccin Latte";
      command = "${getExe pkgs.zsh} -c ${getExe pkgs.nushell} --login";
    };
  };
}
