{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    "${modulesPath}/profiles/headless.nix"
    ../../modules/nixos/base.nix
    ../../modules/nixos/cluster.nix
    ../../modules/nixos/longhorn.nix
    ../../modules/nixos/machine.nix
    ../../modules/nixos/network.nix
    ../../modules/nixos/nishir.nix
  ];

  fileSystems."/mnt/nishir" = {
    device = "/dev/disk/by-label/flandre";
    options = [
      "defaults"
      "nofail"
    ];
  };

  home-manager.users.nishir.imports = [
    ./users/nishir/home-configuration.nix
  ];

  networking.hostName = "minish";

  services.k3s.serverAddr = "https://nishir.taila659a.ts.net:6443";

  services.tailscale = {
    extraUpFlags = [ "--ssh" ];
    useRoutingFeatures = "server";
  };

  users.users.nishir = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/nishir";
    useDefaultShell = true;
  };
}
