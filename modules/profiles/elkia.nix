{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    "${modulesPath}/profiles/headless.nix"
  ];

  networking.hostName = "elkia";
}
