{
  imports = [
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../users/shikanimedeva.nix
  ];

  homebrew.casks = [
    "appcleaner"
    "discord"
    "google-drive"
    "jellyfin-media-player"
    "microsoft-teams"
    "obs"
    "signal"
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
