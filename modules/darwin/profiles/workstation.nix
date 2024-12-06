{
  nix.linux-builder.enable = true;

  homebrew = {
    enable = true;
    brews = [
      "pinentry"
      "pinentry-mac"
    ];
    casks = [
      "android-studio"
      "dbeaver-community"
      "firefox@developer-edition"
      "google-chrome@dev"
      "microsoft-edge@dev"
      "mongodb-compass"
      "rancher"
      "redisinsight"
      "virtualbox"
      "visual-studio-code"
      "wireshark"
      "xquartz"
    ];
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
