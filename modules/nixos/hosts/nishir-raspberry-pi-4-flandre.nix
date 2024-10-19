{
  imports = [
    ./nishir-raspberry-pi-4.nix
  ];

  systemd.mounts = [
    {
      what = "/dev/disk/by-label/flandre";
      where = "/mnt/flandre";
      description = "Mount Flandre";
    }
  ];
  systemd.automounts = [
    {
      where = "/mnt/flandre";
      description = "Automount Flandre";
      wantedBy = [ "multi-user.target" ];
    }
  ];

  services.k3s.tokenFile = "/mnt/flandre/secrets/k3s-token";

  services.tailscale.authKeyFile = "/mnt/flandre/secrets/tailscale-authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:flandre";

  networking.hostName = "flandre";
}
