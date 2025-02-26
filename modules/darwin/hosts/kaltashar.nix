{
  imports = [
    ../profiles/base.nix
    ../profiles/desktop.nix
    ../profiles/workstation.nix
    ../users/shikanimedeva.nix
  ];

  homebrew.casks = [
    "appcleaner"
    "discord"
    "google-drive"
    "jellyfin-media-player"
    "jellyfin"
    "microsoft-teams"
    "obs"
    "prowlarr"
    "radarr"
    "signal"
    "sonarr"
    "spotify"
    "steam"
    "stolendata-mpv"
    "syncthing"
    "tailscale"
    "transmission"
    "whatsapp"
    "zoom"
  ];

  networking.hostName = "kaltashar";
}
