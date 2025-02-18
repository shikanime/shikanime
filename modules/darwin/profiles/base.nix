{
  # Make home-manger use packages from system
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # Clearnup disk weekly
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
    interval = [ { Weekday = 7; } ];
  };

  # Optimize nix store weekly
  nix.optimise = {
    automatic = true;
    interval = [ { Weekday = 7; } ];
  };

  # Allow admin users to interact with the daemon
  nix.settings.trusted-users = [
    "root"
    "@admin"
  ];

  # This value determines the Darwin release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system
  system.stateVersion = 6;
}
