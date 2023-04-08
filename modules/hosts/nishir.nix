{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64-installer.nix"
  ];

  boot.kernelParams = [
    "8250.nr_uarts=1"
    "console=ttyAMA0,115200"
    "console=tty1"
    "cma=128M"
    "cgroup_enable=cpuset"
    "cgroup_memory=1"
    "cgroup_enable=memory"
  ];

  # https://github.com/NixOS/nixpkgs/issues/191095
  boot.kernelPackages = pkgs.linuxKernel.kernels.linux_rpi4;

  hardware.raspberry-pi."4" = {
    fkms-3d.enable = true;
    audio.enable = true;
    dwc2.enable = true;
    poe-hat.enable = true;
    poe-plus-hat.enable = true;
  };

  # https://github.com/NixOS/nixpkgs/issues/154163#issuecomment-1008362877
  nixpkgs.overlays = [
    (_: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  # This is required so that pod can reach the API server (running on port 6443 by default)
  networking.firewall.allowedTCPPorts = [ 6443 ];

  services.k3s = {
    enable = true;
    role = "server";
  };

  networking.hostName = "nishir";
}
