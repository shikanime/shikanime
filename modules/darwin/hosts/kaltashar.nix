{
  imports = [
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../users/shikanimedeva.nix
  ];

  homebrew = {
    brews = [
      "jackett"
    ];
    casks = [
      "appcleaner"
      "discord"
      "google-drive"
      "jellyfin"
      "jellyfin-media-player"
      "microsoft-teams"
      "obs"
      "radarr"
      "signal"
      "sonarr"
      "spotify"
      "steam"
      "stolendata-mpv"
      "syncthing"
      "tailscale"
      "transmission"
      "wacom-tablet"
      "whatsapp"
      "zoom"
    ];
  };

  networking.hostName = "kaltashar";
}
