{
  nix.linux-builder.enable = true;

  homebrew = {
    enable = true;
    casks = [
      "android-studio"
      "appcleaner"
      "dbeaver-community"
      "discord"
      "firefox@developer-edition"
      "google-chrome@dev"
      "google-drive"
      "jellyfin-media-player"
      "microsoft-edge@dev"
      "microsoft-teams"
      "mongodb-compass"
      "obs"
      "pinentry-mac"
      "rancher"
      "redisinsight"
      "signal"
      "sonarr"
      "spotify"
      "steam"
      "stolendata-mpv"
      "syncthing"
      "tailscale"
      "transmission"
      "virtualbox"
      "visual-studio-code"
      "wacom-tablet"
      "whatsapp"
      "wireshark"
      "xquartz"
      "zoom"
      ];
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
