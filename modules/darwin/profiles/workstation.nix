{
  nix.linux-builder.enable = true;

  homebrew = {
    enable = false;
    brews = [
      "openssl"
      "pinentry-mac"
      "pinentry"
      "pkg-config"
    ];
    casks = [
      "android-studio"
      "dbeaver-community"
      "firefox@developer-edition"
      "google-chrome@dev"
      "microsoft-edge@dev"
      "mongodb-compass"
      "rancher"
      "redis-insight"
      "visual-studio-code"
      "windows-app"
      "wireshark"
      "wireshark-chmodbpf"
      "xquartz"
    ];
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
