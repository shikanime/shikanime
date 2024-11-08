{
  # Required by Longhorn
  services.openiscsi.enable = true;

  # Enable iscsi protocol support at kernel level
  boot.kernelModules = [ "iscsi_tcp" ];
}