{ lib, ... }:

with lib;

{
  imports = [
    ./nishir-raspberry-pi-4.nix
  ];

  systemd.mounts = [
    {
      what = "/dev/disk/by-label/remilia";
      where = "/mnt/remilia";
      description = "Mount Remilia";
    }
  ];
  systemd.automounts = [
    {
      where = "/mnt/remilia";
      description = "Automount Remilia";
      wantedBy = [ "multi-user.target" ];
    }
  ];

  services.k3s.tokenFile = "/mnt/remilia/secrets/k3s-token";

  services.tailscale.authKeyFile = "/mnt/remilia/secrets/tailscale-authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:remilia";

  networking.hostName = "remilia";
}
