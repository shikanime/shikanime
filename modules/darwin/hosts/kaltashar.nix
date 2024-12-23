{ pkgs, ... }:

{
  imports = [
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../users/shika.nix
  ];

  environment.systemPackages = [
    pkgs.pinentry_mac
  ];

  homebrew.casks = [
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

  networking.hostName = "kaltashar";
}
