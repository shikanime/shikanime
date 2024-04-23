{
  # Set default time zone
  time.timeZone = "UTC";

  # Clearnup disk weekly
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Automatically upgrade NixOS
  system.autoUpgrade = {
    enable = true;
    flake = "github:shikanime/shikanime";
  };

  # Increase the number of file descriptors and processes
  boot.kernel.sysctl = {
    "kernel.threads-max" = 8192;
    "fs.file-max" = 131072;
    "vm.max_map_count" = 1048576;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  system.stateVersion = "24.05";
}
