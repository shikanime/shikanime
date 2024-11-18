{ lib, modulesPath, ... }:

with lib;

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/cluster.nix
    ../profiles/longhorn.nix
    ../profiles/machine.nix
    ../profiles/network.nix
    ../profiles/nishir.nix
    ../users/nishir.nix
  ];

  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/mmcblk1";
    content = {
      type = "gpt";
      partitions = {
        boot = {
          size = "1M";
          type = "EF02";
        };
        ESP = {
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        root = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };

  fileSystems."/mnt/flandre".device = "/dev/disk/by-label/flandre";

  services.tailscale.authKeyFile = "/etc/secrets/tailscale/authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:flandre";

  services.k3s = {
    serverAddr = "nishir.taila659a.ts.net";
    tokenFile = "/etc/secrets/k3s/token";
    extraFlags = escapeShellArgs [
      "--tls-san"
      "flandre.taila659a.ts.net"
      "--data-dir"
      "/mnt/flandre/rancher/k3s"
      "--flannel-backend"
      "wireguard-native"
      "--node-ip"
      "100.77.250.102,fd7a:115c:a1e0::b101:fa66"
      "--cluster-cidr"
      "10.42.0.0/16,2001:cafe:42::/56"
      "--service-cidr"
      "10.43.0.0/16,2001:cafe:43::/112"
      "--disable-etcd"
    ];
  };

  networking.hostName = "flandre";
}
