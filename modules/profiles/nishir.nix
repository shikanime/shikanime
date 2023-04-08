{
  networking = {
    hostName = "nishir";
    wireless = {
      enable = true;
      interfaces = [ "wlan0" ];
    };
  };

  services.openssh.enable = true;

  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;
}
