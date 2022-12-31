{
  home.homeDirectory = "/Users/williamphetsinorath";
  home.username = "williamphetsinorath";

  programs.zsh.initExtra = ''
    # Source Anaconda3 if it exists
    if [ -d /usr/local/anaconda3 ]; then
      source /usr/local/anaconda3/bin/activate
    fi
  '';
}
