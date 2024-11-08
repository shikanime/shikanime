{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.docker-credential-helpers
  ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  programs.zsh.enable = true;

  programs.nix-ld.enable = true;

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
}
