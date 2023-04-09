{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/virtualisation/hyperv-image.nix"
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_hardened;

  # Resize Hyper-V default disk size
  hyperv.baseImageSize = 64 * 1024;

  networking.hostName = "elvengard";
}
