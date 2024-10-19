{
  imports = [
    ./nishir-raspberry-pi-4.nix
  ];

  fileSystems."/mnt/remilia".device = "/dev/disk/by-label/remilia";

  services.k3s.tokenFile = "/mnt/remilia/secrets/k3s-token";

  services.tailscale.authKeyFile = "/mnt/remilia/secrets/tailscale-authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:remilia";

  networking.hostName = "remilia";
}
