{
  imports = [
    ./nishir-raspberry-pi-4.nix
  ];

  fileSystems."/mnt/flandre".device = "/dev/disk/by-label/flandre";

  services.k3s.tokenFile = "/mnt/flandre/secrets/k3s-token";

  services.tailscale.authKeyFile = "/mnt/flandre/secrets/tailscale-authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:flandre";

  networking.hostName = "flandre";
}
