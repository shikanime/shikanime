{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../profiles/k3s.nix
    ../users/shika.nix
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;

  boot.kernelParams = [
    "8250.nr_uarts=1"
    "console=ttyAMA0,115200"
    "console=tty1"
    "cma=128M"
  ];

  boot.kernel.sysctl = {
    "kernel.threads-max" = 8192;
    "fs.inotify.max_user_watches" = 524288;
    "fs.inotify.max_user_instances" = 8192;
    "fs.inotify.max_queued_events" = 16384;
    "fs.file-max" = 131072;
    "user.max_inotify_instances" = 8192;
    "user.max_inotify_watches" = 524288;
    "vm.max_map_count" = 1048576;
  };

  # Longhorn requires open-
  services.openiscsi = {
    enable = true;
    name = "iqn.2011-11.studio.shikanime:nishir";
  };

  networking.hostName = "nishir";
}
