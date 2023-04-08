{
  networking = {
    hostName = "nishir";
    wireless = {
      enable = true;
      interfaces = [ "wlan0" ];
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
