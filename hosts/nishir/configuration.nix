{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    "${modulesPath}/profiles/headless.nix"
    ../../modules/nixos/base.nix
    ../../modules/nixos/kubernetes.nix
    ../../modules/nixos/longhorn.nix
    ../../modules/nixos/machine.nix
    ../../modules/nixos/tailscale.nix
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

  # https://github.com/NixOS/nixpkgs/issues/154163#issuecomment-1008362877
  nixpkgs.overlays = [
    (_: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  services.kubernetes = {
    addons.dns.enable = true;
    apiserver.advertiseAddress = "100.117.159.56";
    apiserverAddress = "https://nishir.taila659a.ts.net:6443";
    masterAddress = "nishir.taila659a.ts.net";
    roles = [
      "master"
      "node"
    ];
  };

  services.tailscale = {
    extraUpFlags = [ "--ssh" ];
    useRoutingFeatures = "server";
  };

  users.users.nishir = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/nishir";
  };
}
