{ modulesPath, lib, ... }:

with lib;

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

  services.tailscale.authKeyFile = "/mnt/remilia/secrets/tailscale-authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:remilia";

  services.k3s = {
    role = "server";
    tokenFile = "/mnt/remilia/secrets/k3s-token";
    environmentFile = "/mnt/remilia/secrets/k3s-environment";
    extraFlags = escapeShellArgs [
      "--tls-san"
      "nishir.taila659a.ts.net"
      "--cluster-cidr"
      "10.42.0.0/16,2001:cafe:42::/56"
      "--service-cidr"
      "10.43.0.0/16,2001:cafe:43::/112"
      "--data-dir"
      "/media/shika/remilia/rancher/k3s"
      "--node-ip"
      "100.93.169.85,fd7a:115c:a1e0::c301:a955"
      "--cni"
      "multus,canal"
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
