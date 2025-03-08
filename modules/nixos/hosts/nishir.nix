{ modulesPath, ... }:

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

  fileSystems."/mnt/nishir" = {
    device = "/dev/disk/by-label/remilia";
    options = [
      "defaults"
      "nofail"
    ];
  };

  networking.hostName = "nishir";

  services.k3s.role = "server";
}
