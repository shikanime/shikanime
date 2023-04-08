{ config, pkgs, lib, modulesPath, ... }:

with lib;

{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/virtualisation/qemu-vm.nix"
  ];

  # Configure Home Manager to use NixOS global packages
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  system.build.qcowImage = import "${pkgs.path}/nixos/lib/make-disk-image.nix" {
    inherit lib config pkgs;
    diskSize = 64 * 1024;
    format = "qcow2";
  };

  networking.hostName = "elkia";
}
