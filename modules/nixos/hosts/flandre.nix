{ modulesPath, lib, ... }:

with lib;

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../profiles/cluster.nix
    ../profiles/nishir.nix
    ../users/nishir.nix
  ];

  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/sda";
    content = {
      type = "gpt";
      partitions = {
        boot = {
          size = "1M";
          type = "EF02"; # for grub MBR
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

  services.tailscale.authKeyFile = "/mnt/flandre/secrets/tailscale-authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:flandre";

  services.k3s = {
    role = "agent";
    serverAddr = "remilia.taila659a.ts.net";
    tokenFile = "/mnt/flandre/secrets/k3s-token";
    extraFlags = escapeShellArgs [
      "--tls-san"
      "flandre.taila659a.ts.net"
      "--data-dir"
      "/media/shika/flandre/rancher/k3s"
      "--node-ip"
      "100.127.139.42, fd7a:115c:a1e0::6601:8b2a"
      "--service-cidr"
      "10.43.0.0/16,2001:cafe:43::/112"
    ];
  };

  networking.hostName = "flandre";
}
