{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/virtualisation/hyperv-image.nix"
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal-new-kernel.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../profiles/editor.nix
    ../profiles/workstation.nix
    ../profiles/syncthing.nix
    ../profiles/jetbrains.nix
    ../profiles/vscode.nix
    ../users/vscode.nix
  ];

  boot.kernelParams = [ "cgroup_enable=memory" ];

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];

  networking.hostName = "ishtar";
}
