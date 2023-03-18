{ config, pkgs, lib, modulesPath, ... }:

with lib;

{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  system.build.qcowImage = import "${pkgs.path}/nixos/lib/make-disk-image.nix" {
    inherit lib config pkgs;
    diskSize = 64 * 1024;
    format = "qcow2";
  };
}
