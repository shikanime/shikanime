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

  networking.hostName = "nixtar";

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      "--cluster-cidr 10.42.0.0/16,2001:cafe:42::/56"
      "--flannel-backend host-gw"
      "--node-ip 100.111.162.12,fd7a:115c:a1e0::7e01:a20c"
      "--service-cidr 10.43.0.0/16,2001:cafe:43::/112"
      "--tls-san nixtar.taila659a.ts.net"
    ];
  };

  wsl.defaultUser = "shika";
}
