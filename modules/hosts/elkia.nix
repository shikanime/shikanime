{ config, pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/virtualisation/qemu-machine.nix"
  ];

  system.build.qcowImage = import "${pkgs.path}/nixos/lib/make-disk-image.nix" {
    inherit lib config pkgs;
    diskSize = 64 * 1024;
    format = "qcow2";
  };

  networking.hostName = "elkia";
}
