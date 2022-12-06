{
  home.homeDirectory = "/Users/williamphetsinorath";
  home.username = "williamphetsinorath";

  programs.zsh.initExtra = ''
    # Enable Brew integration
    if which brew > /dev/null; then
      eval $(brew shellenv)
    fi

    # set PATH so it includes Rancher Desktop's bin if it exists
    if [ -d $HOME/.rd ]; then
      export PATH=$HOME/.rd/bin:$PATH
    fi

    # Source Anaconda3 if it exists
    if [ -d /usr/local/anaconda3 ]; then
      source /usr/local/anaconda3/bin/activate
    fi

    # Source Google Cloud SDK if it exists
    if [ -d /usr/local/Caskroom/google-cloud-sdk ]; then
      source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
    fi
  '';

  programs.ssh = {
    extraConfig = ''
      UseKeychain Yes
    '';
    extraOptionOverrides = {
      IgnoreUnknown = "UseKeychain";
    };
  };
}
