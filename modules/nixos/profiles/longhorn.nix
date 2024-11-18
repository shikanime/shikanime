{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.cryptsetup
    pkgs.lvm2
    pkgs.nfs-utils
  ];

  # FIXME: https://github.com/longhorn/longhorn/issues/2166
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];

  services.openiscsi.enable = true;

  # Enable iscsi protocol support at kernel level
  boot.kernelModules = [ "dm_crypt" "iscsi_tcp" ];

  # Enable NFS support at kernel level
  boot.supportedFilesystems = [ "nfs" ];

  boot.kernelPatches = [
    {
      name = "config-6.6.31";
      patch = null;
      extraConfig = ''
        CONFIG_DM_CRYPT=dm_crypt
        CONFIG_NFS_V4=nfs
        CONFIG_NFS_V4_1=nfs
        CONFIG_NFS_V4_2=nfs
      '';
    }
  ];
}
