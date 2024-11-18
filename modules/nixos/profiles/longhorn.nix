{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.cryptsetup
    pkgs.lvm2
    pkgs.nfs-utils
    pkgs.openiscsi
  ];

  # Enable iscsi protocol support at kernel level
  boot.kernelModules = [ "iscsi_tcp" ];

  # Enable NFS support at kernel level
  boot.supportedFilesystems = [ "nfs" ];
}
