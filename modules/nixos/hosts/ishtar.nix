{ lib, ... }:

with lib;

{
  imports = [
    ../profiles/base.nix
    ../profiles/cluster.nix
    ../profiles/wsl.nix
    ../users/shika.nix
  ];

  wsl.defaultUser = "shika";

  services.k3s = {
    role = "agent";
    serverAddr = "https://nishir.taila659a.ts.net:6443";
    configPath = "/etc/rancher/k3s/config.yaml";
    extraFlags = escapeShellArgs [
      "--node-ip"
      "100.77.66.124,fd7a:115c:a1e0::1c01:427c"
    ];
  };

  networking.hostName = "ishtar";
}
