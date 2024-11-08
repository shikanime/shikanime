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

  fileSystems."/mnt/flandre".device = "/dev/disk/by-label/flandre";

  services.tailscale.authKeyFile = "/mnt/flandre/secrets/tailscale-authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:flandre";

  services.k3s = {
    role = "agent";
    serverAddr = "remilia.taila659a.ts.net";
    tokenFile = "/mnt/flandre/secrets/k3s-token";
    extraFlags = escapeShellArgs ''
      --tls-san flandre.taila659a.ts.net
      --data-dir /media/shika/flandre/rancher/k3s
      --node-ip 100.127.139.42, fd7a:115c:a1e0::6601:8b2a
      --service-cidr 10.43.0.0/16,2001:cafe:43::/112
    '';
  };

  networking.hostName = "flandre";
}
