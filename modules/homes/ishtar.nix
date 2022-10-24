{ config, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  programs.zsh.initExtra = ''
    # Source Anaconda3 if it exists
    if [ -d ${config.xdg.dataHome}/anaconda3 ]; then
      source ${config.xdg.dataHome}/anaconda3/bin/activate
    fi
  '';
}
