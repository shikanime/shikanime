{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
  ];

  networking.hostName = "elkia";
}
