{
  # Enable the Bonjour protocol for local network discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Enable SSH access
  services.openssh = {
    enable = true;
    openFirewall = true;
  };
}
