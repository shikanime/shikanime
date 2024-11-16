{ lib, modulesPath, ... }:

with lib;

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/cluster.nix
    ../profiles/workstation.nix
    ../profiles/wsl.nix
    ../users/shika.nix
  ];

  wsl.defaultUser = "shika";

  services.k3s = {
    role = "agent";
    serverAddr = "https://nishir.taila659a.ts.net:6443";
    tokenFile = "/etc/secrets/k3s/token";
    extraFlags = escapeShellArgs [
      "--node-ip"
      "100.86.141.66,fd7a:115c:a1e0::6601:8d42"
      "--node-label"
      "node.nishir/longhorn-unavailable"
    ];
  };

  networking.hostName = "ishtar";
}
