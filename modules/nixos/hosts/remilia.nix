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

  fileSystems."/mnt/remilia".device = "/dev/disk/by-label/remilia";

  services.tailscale.authKeyFile = "/etc/secrets/tailscale/authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:remilia";

  services.k3s = {
    role = "server";
    tokenFile = "/etc/secrets/k3s/token";
    configPath = "/etc/secrets/k3s/config.yaml";
    extraFlags = escapeShellArgs [
      "--tls-san"
      "nishir.taila659a.ts.net"
      "--cluster-cidr"
      "10.42.0.0/16,2001:cafe:42::/56"
      "--service-cidr"
      "10.43.0.0/16,2001:cafe:43::/112"
      "--data-dir"
      "/mnt/remilia/rancher/k3s"
      "--node-ip"
      "100.93.169.85,fd7a:115c:a1e0::c301:a955"
      "--flannel-backend"
      "wireguard-native"
      "--etcd-s3"
      "true"
      "--etcd-s3-endpoint"
      "s3.fr-par.scw.cloud"
      "--etcd-s3-region"
      "fr-par"
      "--etcd-s3-bucket"
      "shikanime-studio-fr-par-etcd-backups"
    ];
  };

  networking.hostName = "remilia";
}
