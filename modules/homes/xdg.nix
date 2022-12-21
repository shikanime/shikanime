{ config, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      XDG_SYNC_DIR = "${config.home.homeDirectory}/Sync";
      XDG_SOURCE_DIR = "${config.home.homeDirectory}/Source";
    };
  };
}
