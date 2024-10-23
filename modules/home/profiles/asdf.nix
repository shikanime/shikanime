{ config, pkgs, ... }:

{
  home.sessionVariables.ASDF_DATA_DIR = "${config.xdg.configHome}/asdf";

  home.packages = [
    pkgs.asdf-vm
  ];

  programs.zsh.initExtra = ''
    if [ -e "${config.home.homeDirectory}/.asdf/asdf.sh" ]; then
      . "${config.home.homeDirectory}/.asdf/asdf.sh"
    fi
  '';
}
