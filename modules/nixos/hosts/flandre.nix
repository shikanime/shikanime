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

  fileSystems."/mnt/flandre" = {
    device = "/dev/disk/by-label/flandre";
    options = [
      "defaults"
      "nofail"
    ];
  };

  networking.hostName = "flandre";

  services.k3s = {
    configPath = "/etc/flandre/k3s/config.yaml";
    serverAddr = "https://nishir.taila659a.ts.net:6443";
    tokenFile = "/etc/flandre/k3s/token";
  };

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:flandre";

  services.tailscale.authKeyFile = "/etc/flandre/tailscale/authkey";
}
