{ lib, modulesPath, ... }:

with lib;

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/cluster.nix
    ../profiles/longhorn.nix
    ../profiles/machine.nix
    ../profiles/network.nix
    ../profiles/nishir.nix
    ../users/nishir.nix
  ];

  fileSystems."/mnt/remilia" = {
    device = "/dev/disk/by-label/remilia";
    options = [ "defaults" "nofail" ];
  };

  services.tailscale.authKeyFile = "/etc/secrets/tailscale/authkey";

  services.k3s = {
    role = "server";
    tokenFile = "/etc/secrets/k3s/token";
    configPath = "/etc/secrets/k3s/config.yaml";
  };

  networking.hostName = "remilia";
}
