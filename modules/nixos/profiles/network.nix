{
  # Enable Tailscale traffic optimizations
  boot.kernel.sysctl = {
    "net.core.rmem_default" = 7340032;
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  # Enable VPN access
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "server";
    extraUpFlags = [
      "--ssh"
      "--advertise-exit-node"
    ];
  };
}
