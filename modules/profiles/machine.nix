{
  # Enable modern IPv6 support
  networking.enableIPv6 = true;

  # Enable well known secure DNS servers
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
    "8.8.8.8"
    "8.8.4.4"
    "2001:4860:4860::8888"
    "2001:4860:4860::8844"
  ];

  # Enable the Bonjour protocol for local network discovery
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Enable Network Time Protocol
  services.ntp.enable = true;

  # Enable the Geoclue2 location service
  services.geoclue2.enable = true;

  # Keep the system timezone up-to-date based on the current location
  services.localtimed.enable = true;
}
