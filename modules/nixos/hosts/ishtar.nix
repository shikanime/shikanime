{ modulesPath, ... }:
{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/cluster.nix
    ../profiles/networking.nix
    ../profiles/workstation.nix
    ../profiles/wsl.nix
    ../users/shika.nix
  ];

  wsl.defaultUser = "shika";

  services.k3s = {
    role = "agent";
    serverAddr = "https://nishir.taila659a.ts.net:6443";
    configPath = "/etc/rancher/k3s/config.yaml";
  };

  networking.hostName = "ishtar";
}
