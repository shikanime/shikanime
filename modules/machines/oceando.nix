{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/docker-container.nix"
  ];

  # Iptables do not work in Docker.
  networking.firewall.enable = false;

  # Socket activated ssh presents problem in Docker.
  services.openssh.startWhenNeeded = false;

  # Define network name
  networking.hostName = "oceando";
}
