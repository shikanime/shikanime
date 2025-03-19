{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/cluster.nix
    ../profiles/network.nix
    ../profiles/workstation.nix
    ../profiles/wsl.nix
    ../users/shika.nix
  ];

  networking.hostName = "nixtar";

  services.k3s = {
    enable = true;
    role = "server";
  };

  wsl.defaultUser = "shika";
}
