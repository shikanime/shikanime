{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.cryptsetup
    pkgs.lvm2
    pkgs.nfs-utils
  ];

  services.openiscsi.enable = true;

  # Enable iscsi protocol support at kernel level
  boot.kernelModules = [ "iscsi_tcp" ];
}
