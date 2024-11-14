{
  # Allow wheel users to interact with the daemon
  nix.settings.trusted-users = [ "root" "@wheel" ];

  # Clearnup disk weekly
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Optimize nix store weekly
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # Automatically upgrade NixOS
  system.autoUpgrade = {
    enable = true;
    flake = "github:shikanime/shikanime";
  };

  # Make home-manger use packages from system
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  system.stateVersion = "24.05";
}
