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
      "slack"
      "spotify"
      "stolendata-mpv"
      "syncthing-app"
      "tailscale-app"
      "trae"
      "transmission"
      "visual-studio-code"
      "windows-app"
      "wireshark-app"
      "xquartz"
      "zen"
      "zoom"
    ];
    masApps = {
      Amphetamine = 937984704;
      Bitwarden = 1352778147;
      Velja = 1607635845;
      Xcode = 497799835;
    };
  };

  programs.zsh = {
    enable = true;
    shellInit = mkAfter ''
      if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
