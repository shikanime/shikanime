{
  # Enable Tailscale traffic optimizations
  boot.kernel.sysctl = {
    "net.core.rmem_default" = 7340032;
  };

  # Enable SSH access
  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  # Enable VPN access
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };
}
