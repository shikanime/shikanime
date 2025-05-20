{
  nix.linux-builder.enable = true;

  homebrew = {
    enable = true;
    brews = [
      "mas"
      "openssl"
      "pinentry-mac"
      "pinentry"
      "pkg-config"
    ];
    casks = [
      "android-studio"
      "dbeaver-community"
      "ghostty"
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
    masApps = {
      Bitwarden = 1352778147;
      Xcode = 497799835;
    };
  };

  programs.fish.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
