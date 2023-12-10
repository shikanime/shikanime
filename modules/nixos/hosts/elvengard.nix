{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/virtualisation/hyperv-image.nix"
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
../../home/profiles/base.nix
../../home/profiles/machine.nix
../../home/profiles/editor.nix
../../home/profiles/workstation.nix
../../home/profiles/syncthing.nix
../../home/profiles/jetbrains.nix
../../home/profiles/vscode.nix
../../home/users/vscode.nix
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_hardened;

  boot.kernelParams = [ "cgroup_enable=memory" ];

  # Resize Hyper-V default disk size
  hyperv.baseImageSize = 64 * 1024;

  networking.hostName = "elvengard";
}
