{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/cluster.nix
    ../profiles/workstation.nix
    ../profiles/wsl.nix
    ../users/shika.nix
  ];

  networking.hostName = "ishtar";

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      "--cluster-cidr 10.42.0.0/16,2001:cafe:42::/56"
      "--flannel-backend host-gw"
      "--service-cidr 10.43.0.0/16,2001:cafe:43::/112"
      "--tls-san ishtar.taila659a.ts.net"
    ];
  };

  wsl.defaultUser = "shika";
}
