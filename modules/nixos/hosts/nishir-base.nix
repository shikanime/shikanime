{ pkgs, lib, modulesPath, ... }:

with lib;

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../profiles/k3s.nix
    ../users/shika.nix
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;

  boot.kernelParams = [
    "8250.nr_uarts=1"
    "console=ttyAMA0,115200"
    "console=tty1"
    "cma=128M"
  ];

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:nishir";

  networking.hostName = "nishir";
}
