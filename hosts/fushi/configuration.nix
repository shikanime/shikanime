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

  fileSystems."/mnt/reimu" = {
    device = "/dev/disk/by-label/reimu";
    options = [
      "defaults"
      "nofail"
      "x-systemd.automount"
    ];
  };

  # Enable accelerator
  hardware.raspberry-pi."4" = {
    fkms-3d.enable = true;
    apply-overlays-dtmerge.enable = true;
  };

  home-manager.users.nishir.imports = [
    ./users/nishir/home-configuration.nix
  ];

  networking.hostName = "fushi";

  # https://github.com/NixOS/nixpkgs/issues/154163#issuecomment-1008362877
  nixpkgs.overlays = [
    (_: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  services.kubernetes = {
    apiserverAddress = "https://nishir.taila659a.ts.net:6443";
    kubelet.kubeconfig.server = "https://nishir.taila659a.ts.net:6443";
    masterAddress = "nishir.taila659a.ts.net";
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
