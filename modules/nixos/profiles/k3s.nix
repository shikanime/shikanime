{
  services.k3s = {
    enable = true;
    role = "server";
  };

  boot.kernelParams = [
    "cgroup_enable=cpuset"
    "cgroup_enable=memory"
    "cgroup_memory=1"
  ];
}
