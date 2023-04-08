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
    ];
    loader.raspberryPi = {
      enable = true;
      version = 4;
    };
  };

  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;

  # This is required so that pod can reach the API server (running on port 6443 by default)
  networking.firewall.allowedTCPPorts = [ 6443 ];

  services.k3s = {
    enable = true;
    role = "server";
  };
}
