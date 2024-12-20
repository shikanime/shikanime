{ config, pkgs, ... }:

{
  home.sessionVariables.GOPATH = "${config.xdg.dataHome}/go";

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];

  programs.nushell.extraConfig = ''
    source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/godoc/godoc-completions.nu
  '';
}
