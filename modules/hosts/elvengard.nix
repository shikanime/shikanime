{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/virtualisation/hyperv-image.nix"
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../profiles/workstation.nix
    ../profiles/syncthing.nix
    ../profiles/jetbrains.nix
    ../profiles/vscode.nix
    ../users/vscode.nix
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_hardened;

  boot.kernelParams = [ "cgroup_enable=memory" ];

  # Resize Hyper-V default disk size
  hyperv.baseImageSize = 64 * 1024;

  networking.hostName = "elvengard";
}
