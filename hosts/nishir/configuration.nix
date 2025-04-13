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
    device = "/dev/nvme0n1";
    options = [
      "defaults"
      "nofail"
    ];
  };

  home-manager.users.nishir.imports = [
    ./users/nishir/home-configuration.nix
  ];

  networking.hostName = "nishir";

  services.k3s.role = "server";

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
