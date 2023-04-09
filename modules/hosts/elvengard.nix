{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/virtualisation/hyperv-image.nix"
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_hardened;

  # https://github.com/k2s-io/k3s/issues/2067
  boot.kernelParams = [
    "cgroup_enable=memory"
  ];

  # Resize Hyper-V default disk size
  hyperv.baseImageSize = 64 * 1024;

  networking.hostName = "elvengard";
}
