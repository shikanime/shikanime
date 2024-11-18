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

  fileSystems."/mnt/flandre" = {
    device = "/dev/disk/by-label/flandre";
    options = [ "defaults" "nofail" ];
  };

  services.tailscale.authKeyFile = "/etc/secrets/tailscale/authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:flandre";

  services.k3s = {
    serverAddr = "https://nishir.taila659a.ts.net:6443";
    tokenFile = "/etc/secrets/k3s/token";
    configPath = "/etc/secrets/k3s/config.yaml"
  };

  networking.hostName = "flandre";
}
