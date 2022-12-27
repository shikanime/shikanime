{
  # Enable Brew integration
  programs.zsh.initExtra = ''
    if which brew > /dev/null; then
      eval $(brew shellenv)
    fi
  '';

  # Enable SSH keychain
  programs.ssh = {
    extraConfig = ''
      UseKeychain Yes
    '';
  };
}
