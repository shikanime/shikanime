{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableExtraSocket = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    settings.default-cache-ttl = 60 * 60;
  };

  programs.nix-ld.enable = true;

  programs.zsh.enable = true;

  services.coder.enable = true;

  users.extraGroups.docker.members = [ "coder" ];
}
