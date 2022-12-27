{ config, ... }:

{
  home.homeDirectory = "/Users/williamphetsinorath";
  home.username = "williamphetsinorath";

  programs.zsh.initExtra = ''
    # set PATH so it includes Rancher Desktop's bin if it exists
    if [ -d ${config.home.homeDirectory}/.rd ]; then
      export PATH=${config.home.homeDirectory}/.rd/bin:$PATH
    fi

    # Source Anaconda3 if it exists
    if [ -d /usr/local/anaconda3 ]; then
      source /usr/local/anaconda3/bin/activate
    fi
  '';
}
