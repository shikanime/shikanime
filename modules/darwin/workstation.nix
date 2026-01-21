{ lib, ... }:

{
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
      "affinity"
      "android-studio"
      "appcleaner"
      "dbeaver-community"
      "discord"
      "firefox"
      "google-chrome"
      "google-drive"
      "jellyfin-media-player"
      "macfuse"
      "microsoft-edge"
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
    shellInit = lib.mkAfter ''test -f /opt/homebrew/bin/brew && eval "$(/opt/homebrew/bin/brew shellenv)";'';
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
