{ pkgs, ... }:

{
  programs.fish.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableExtraSocket = true;
    pinentryPackage = pkgs.pinentry-all;
    settings.default-cache-ttl = 60 * 60;
  };

  programs.nix-ld.enable = true;

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
}
