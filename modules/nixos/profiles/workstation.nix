{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableExtraSocket = true;
    pinentryPackage = pkgs.pinentry-all;
    settings.default-cache-ttl = 60 * 60;
  };

  programs.nix-ld.enable = true;

  # Enable SSH access
  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  programs.zsh.enable = true;

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
}
