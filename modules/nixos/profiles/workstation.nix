{ pkgs, ... }:

{
  programs.fish.enable = true;

  programs.nix-ld.enable = true;

  # Enable SSH access
  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
}
