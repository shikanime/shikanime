{
  programs.zsh.initExtra = ''
    # Enable Brew integration
    if which brew > /dev/null; then
      eval $(brew shellenv)
    fi

    # set PATH so it includes Rancher Desktop's bin if it exists
    if [ -d $HOME/.rd ]; then
      export PATH=$HOME/.rd/bin:$PATH
    fi
  '';
}
