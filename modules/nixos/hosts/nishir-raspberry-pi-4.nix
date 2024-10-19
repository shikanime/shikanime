{ pkgs, lib, modulesPath, ... }:

with lib;

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    ./nishir-base.nix
  ];

  hardware.raspberry-pi."4" = {
    fkms-3d.enable = true;
    apply-overlays-dtmerge.enable = true;
  };

  # https://github.com/NixOS/nixpkgs/issues/154163#issuecomment-1008362877
  nixpkgs.overlays = [
    (_: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  boot = {
    kernelParams = [
      "8250.nr_uarts=1"
      "console=ttyAMA0,115200"
      "console=tty1"
      "cma=128M"
    ];
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
  };
}
