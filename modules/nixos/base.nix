{
  # Make home-manger use packages from system
  home-manager = {
    backupFileExtension = "backup-before-nix";
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # Clearnup disk weekly
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix = {
    # Optimize nix store weekly
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };

    # Allow wheel users to interact with the daemon
    settings = {
      download-buffer-size = 524288000;
      trusted-users = [ "@wheel" ];
    };
  };

  # Automatically upgrade NixOS
  system.autoUpgrade = {
    enable = true;
    flags = [ "--accept-flake-config" ];
    flake = "github:shikanime/shikanime";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  system.stateVersion = "25.05";
}
