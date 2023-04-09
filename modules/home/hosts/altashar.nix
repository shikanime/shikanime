{ lib, ... }:

with lib;

{
  home.homeDirectory = "/Users/williamphetsinorath";
  home.username = "williamphetsinorath";

  programs.zsh.initExtra = mkAfter ''
    if [ -d /usr/local/anaconda3 ]; then
      source /usr/local/anaconda3/bin/activate
    fi
  '';
}
