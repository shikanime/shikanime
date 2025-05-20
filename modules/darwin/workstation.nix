{
  nix.linux-builder.enable = true;

  homebrew = {
    enable = true;
    brews = [
      "openssl"
      "pinentry-mac"
      "pinentry"
      "pkg-config"
    ];
    casks = [
      "android-studio"
      "bitwarden"
      "dbeaver-community"
      "firefox@developer-edition"
      "google-chrome@dev"
      "macfuse"
      "microsoft-edge@dev"
      "mongodb-compass"
      "rancher"
      "redis-insight"
      "trae"
      "visual-studio-code"
      "windows-app"
      "wireshark"
      "xquartz"
    ];
  };

  programs.fish.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
