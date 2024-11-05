{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
  ];

  boot.kernelParams = [
    "cgroup_enable=cpuset"
    "cgroup_enable=memory"
    "cgroup_memory=1"
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

  users.users.shika = {
    isNormalUser = true;
    home = "/home/shika";
    extraGroups = [ "wheel" ];
    initialHashedPassword = "$y$j9T$HB1msXB0DEq00J48zRpB20$/3rhVrTzGrv1j/cPvZ0clOM2gEe1TeylUG39wgD0C42";
  };

  home-manager.users.shika.imports = [
    ../../home/hosts/nishir-shika.nix
  ];

  services.k3s = {
    enable = true;
    role = "server";
  };

  # Longhorn requires open-iscsi
  services.openiscsi.enable = true;
}
