{ config, ... }:

{
  home.homeDirectory = "/home/devas";
  home.username = "devas";

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  targets.genericLinux.enable = true;

  programs.zsh.initExtra = ''
    # Source Anaconda3 if it exists
    if [ -d ${config.xdg.dataHome}/anaconda3 ]; then
      source ${config.xdg.dataHome}/anaconda3/bin/activate
    fi
  '';

  programs.git.extraConfig.credential.helper = "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe";
}
