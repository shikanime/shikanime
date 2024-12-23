{
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Add extra cache
  nix.settings = {
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "shikanime.cachix.org-1:OrpjVTH6RzYf2R97IqcTWdLRejF6+XbpFNNZJxKG8Ts="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://shikanime.cachix.org"
      "https://devenv.cachix.org"
    ];
  };

  # Enable experimental features so we can access flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree software such as Cloudflared or CUDA
  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release
  home.stateVersion = "25.05";
}
