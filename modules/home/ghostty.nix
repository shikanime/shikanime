{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.nil;
    themes = {
      catppuccin-latte = {
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
      theme = "catppuccin-latte";
      command = "${pkgs.zsh}/bin/zsh -c ${pkgs.nushell}/bin/nu --login";
    };
  };
}
