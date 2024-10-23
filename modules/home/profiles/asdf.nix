{ config, pkgs, ... }:

let
  initExtra = ''
    if [ -e "${config.home.homeDirectory}/.asdf/asdf.sh" ]; then
        . "${config.home.homeDirectory}/.asdf/asdf.sh"
    fi
  '';
in
{
  home.sessionVariables.ASDF_DATA_DIR = "${config.xdg.configHome}/asdf";

  home.packages = [
    pkgs.asdf-vm
  ];

  programs.zsh = { inherit initExtra; };
  programs.bash = { inherit initExtra; };
}
