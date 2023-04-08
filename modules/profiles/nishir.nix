{
  networking = {
    hostName = "nishir";
    wireless = {
      enable = true;
      interfaces = [
        "eth0"
        "wlan0"
      ];
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  boot = {
    tmpOnTmpfs = true;
    kernelParams = [
      "8250.nr_uarts=1"
      "console=ttyAMA0,115200"
      "console=tty1"
      "cma=128M"
      "cgroup_enable=cpuset"
      "cgroup_memory=1"
      "cgroup_enable=memory"
    ];
    loader.raspberryPi = {
      enable = true;
      version = 4;
    };
  };

  hardware.raspberry-pi."4" = {
    fkms-3d.enable = true;
    audio.enable = true;
    dwc2.enable = true;
    poe-hat.enable = true;
    poe-plus-hat.enable = true;
  };

  # This is required so that pod can reach the API server (running on port 6443 by default)
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 6443 ];
  };

  services.k3s = {
    enable = true;
    role = "server";
  };
}
