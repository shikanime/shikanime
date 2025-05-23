{ lib, pkgs, ... }:

with lib;

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
      "adobe-creative-cloud"
      "android-studio"
      "appcleaner"
      "dbeaver-community"
      "discord"
      "ghostty"
      "google-chrome@dev"
      "google-drive"
      "jellyfin-media-player"
      "macfuse"
      "microsoft-edge@dev"
      "microsoft-teams"
      "mongodb-compass"
      "obs"
      "rancher"
      "redis-insight"
      "signal"
      "spotify"
      "steam"
      "stolendata-mpv"
      "syncthing"
      "tailscale"
      "trae"
      "transmission"
      "visual-studio-code"
      "whatsapp"
      "windows-app"
      "wireshark"
      "xquartz"
      "zen"
      "zoom"
    ];
    masApps = {
      Bitwarden = 1352778147;
      "DaVinci Resolve" = 571213070;
      Velja = 1607635845;
      "WhatsApp Messenger" = 310633997;
      Xcode = 497799835;
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = mkAfter ''
      if test -f /opt/homebrew/bin/brew
        eval "$(/opt/homebrew/bin/brew shellenv)"
      end
    '';
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
