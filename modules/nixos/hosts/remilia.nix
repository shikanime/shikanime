{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/cluster.nix
    ../profiles/longhorn.nix
    ../profiles/machine.nix
    ../profiles/network.nix
    ../profiles/nishir.nix
    ../users/nishir.nix
  ];

  fileSystems."/mnt/remilia" = {
    device = "/dev/disk/by-label/remilia";
    options = [
      "defaults"
      "nofail"
    ];
  };

  services.tailscale.authKeyFile = "/etc/remilia/tailscale/authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:remilia";

  services.k3s = {
    role = "server";
    tokenFile = "/etc/remilia/k3s/token";
    configPath = "/etc/remilia/k3s/config.yaml";
  };

  networking.hostName = "remilia";
}
