{ pkgs ? import <nixpkgs> { }, lib, ... }:

with lib;

{
  # Increase the inotify limit
  boot.kernel.sysctl."fs.inotify.max_user_watches" = mkDefault "204800";

  # P2P file synchronization
  home-manager.users.devas.services.syncthing.enable = true;
}
