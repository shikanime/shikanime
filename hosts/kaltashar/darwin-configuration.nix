{
  imports = [
    ../../modules/darwin/base.nix
    ../../modules/darwin/workstation.nix
  ];

  home-manager.users.shikanimedeva.imports = [
    ./users/shikanimedeva/home-configuration.nix
  ];

  homebrew = {
    casks = [
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
      "zen"
    ];
    masApps = {
      "WhatsApp Messenger" = 310633997;
    };
  };

  networking.hostName = "kaltashar";

  system.primaryUser = "shikanimedeva";

  users.users.shikanimedeva = {
    name = "shikanimedeva";
    home = "/Users/shikanimedeva";
  };
}
