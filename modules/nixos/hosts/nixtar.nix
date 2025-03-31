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

  wsl.defaultUser = "shika";
}
