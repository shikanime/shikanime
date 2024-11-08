{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../profiles/cluster.nix
    ../profiles/nishir.nix
  ];

  fileSystems."/mnt/remilia".device = "/dev/disk/by-label/remilia";

  services.k3s.tokenFile = "/mnt/remilia/secrets/k3s-token";

  services.tailscale.authKeyFile = "/mnt/remilia/secrets/tailscale-authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:remilia";

  services.k3s.role = "server";

  networking.hostName = "remilia";
}
