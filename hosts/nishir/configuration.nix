{ config, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/netboot/netboot-minimal.nix"
    "${modulesPath}/profiles/headless.nix"
    ../../modules/nixos/base.nix
    ../../modules/nixos/kubernetes.nix
    ../../modules/nixos/longhorn.nix
    ../../modules/nixos/tailscale.nix
  ];

  fileSystems = {
    "/mnt/flandre" = {
      device = "/dev/disk/by-label/flandre";
      options = [
        "defaults"
        "nofail"
        "x-systemd.automount"
      ];
    };
    "/mnt/nishir" = {
      device = "/dev/nvme0n1";
      options = [
        "defaults"
        "nofail"
        "x-systemd.automount"
      ];
    };
    "/mnt/remilia" = {
      device = "/dev/disk/by-label/remilia";
      options = [
        "defaults"
        "nofail"
        "x-systemd.automount"
      ];
    };
  };

  home-manager.users.nishir.imports = [
    ./users/nishir/home-configuration.nix
  ];

  networking.hostName = "nishir";

  nix.extraOptions = ''
    !include ${config.sops.secrets.nix-config.path}
  '';

  # https://github.com/NixOS/nixpkgs/issues/154163#issuecomment-1008362877
  nixpkgs.overlays = [
    (_: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };

    kubernetes = {
      apiserver.advertiseAddress = "100.117.159.56";
      apiserverAddress = "https://nishir.taila659a.ts.net:6443";
      masterAddress = "nishir.taila659a.ts.net";
      roles = [
        "master"
        "node"
      ];
    };

    openssh = {
      enable = true;
      openFirewall = true;
    };

    tailscale = {
      authKeyFile = config.sops.secrets.tailscale-authkey.path;
      extraUpFlags = [ "--ssh" ];
      useRoutingFeatures = "server";
    };
  };

  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ../../secrets/nishir.enc.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      tailscale-authkey = { };
      nix-config = { };
    };
  };

  users.users.nishir = {
    extraGroups = [ "wheel" ];
    initialHashedPassword = "$y$j9T$HB1msXB0DEq00J48zRpB20$/3rhVrTzGrv1j/cPvZ0clOM2gEe1TeylUG39wgD0C42";
    isNormalUser = true;
    home = "/home/nishir";
  };
}
