{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.gopls
  ];

  programs.go = {
    enable = true;
    goPath = "${config.xdg.dataHome}/go";
    telemetry.mode = "off";
  };

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/godoc/godoc-completions.nu
  '';
}
