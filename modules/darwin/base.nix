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
  nix.settings = {
    download-buffer-size = 524288000;
    substituters = [
      "https://cachix.cachix.org"
      "https://devenv.cachix.org"
      "https://shikanime.cachix.org"
    ];
    trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "shikanime.cachix.org-1:OrpjVTH6RzYf2R97IqcTWdLRejF6+XbpFNNZJxKG8Ts="
    ];
    trusted-users = [
      "root"
      "@admin"
    ];
  };

  # This value determines the Darwin release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system
  system.stateVersion = 6;
}
