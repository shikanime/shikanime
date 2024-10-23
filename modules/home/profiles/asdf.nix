{ config, pkgs, ... }:

{
  home.sessionVariables.ASDF_DATA_DIR = "${config.xdg.configHome}/asdf";

  home.packages = [
    pkgs.asdf-vm
  ];

  programs.zsh.initExtra = ''
    . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
  '';
}
