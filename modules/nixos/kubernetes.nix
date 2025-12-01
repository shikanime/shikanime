{
  # Remove common limitations for fs heavy services such as Syncthing
  boot.kernel.sysctl = {
    "kernel.panic" = 10;
    "kernel.threads-max" = 8192;
    "fs.inotify.max_user_watches" = 524288;
    "fs.inotify.max_user_instances" = 8192;
    "fs.inotify.max_queued_events" = 16384;
    "fs.file-max" = 131072;
    "user.max_inotify_instances" = 8192;
    "user.max_inotify_watches" = 524288;
    "vm.max_map_count" = 1048576;
  };

  # Enable cgroup for K3s
  boot.kernelParams = [
    "cgroup_enable=cpuset"
    "cgroup_enable=memory"
    "cgroup_memory=1"
  ];

  services.kubernetes.kubelet.extraOpts = "--fail-swap-on=false";
}
