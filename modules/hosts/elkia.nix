{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/virtualisation/qemu-vm.nix"
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_hardened;

  boot.kernelParams = [ "cgroup_enable=memory" ];

  system.build.qcowImage = import "${pkgs.path}/nixos/lib/make-disk-image.nix" {
    inherit lib config pkgs;
    diskSize = 64 * 1024;
    format = "qcow2";
  };

  networking.hostName = "elkia";
}
