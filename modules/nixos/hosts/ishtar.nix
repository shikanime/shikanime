{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../profiles/wsl.nix
    ../users/shika.nix
  ];

  wsl.defaultUser = "shika";

  networking.hostName = "ishtar";
}
