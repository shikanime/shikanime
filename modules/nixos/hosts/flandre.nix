{ lib, modulesPath, ... }:

with lib;

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

  fileSystems."/mnt/flandre".device = "/dev/disk/by-label/flandre";

  services.tailscale.authKeyFile = "/etc/secrets/tailscale/authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:flandre";

  services.k3s = {
    serverAddr = "https://nishir.taila659a.ts.net:6443";
    tokenFile = "/etc/secrets/k3s/token";
    extraFlags = escapeShellArgs [
      "--tls-san"
      "flandre.taila659a.ts.net"
      "--cluster-cidr"
      "10.42.0.0/16,2001:cafe:42::/56"
      "--service-cidr"
      "10.43.0.0/16,2001:cafe:43::/112"
      "--data-dir"
      "/mnt/flandre/rancher/k3s"
      "--flannel-backend"
      "wireguard-native"
      "--node-ip"
      "100.77.250.102,fd7a:115c:a1e0::b101:fa66"
      "--disable-etcd"
    ];
  };

  networking.hostName = "flandre";
}
