{ config, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    "${modulesPath}/profiles/headless.nix"
    ../../modules/nixos/base.nix
    ../../modules/nixos/kubernetes.nix
    ../../modules/nixos/longhorn.nix
    ../../modules/nixos/tailscale.nix
  ];

  fileSystems."/mnt/marisa" = {
    device = "/dev/disk/by-label/marisa";
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

  nix.extraOptions = ''
    !include ${config.sops.secrets.nix-config.path}
  '';

  networking.hostName = "minish";

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
      apiserverAddress = "https://nishir.taila659a.ts.net:6443";
      kubelet.kubeconfig.server = "https://nishir.taila659a.ts.net:6443";
      masterAddress = "nishir.taila659a.ts.net";
      roles = [ "node" ];
    };

    tailscale = {
      authKeyFile = config.sops.secrets.tailscale-authkey.path;
      extraUpFlags = [ "--ssh" ];
      useRoutingFeatures = "server";
    };

    openssh = {
      enable = true;
      openFirewall = true;
    };
  };

  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ../../secrets/minish.enc.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      tailscale-authkey = { };
      nix-config = { };
    };
  };

  users.users = {
    nishir = {
      initialHashedPassword = "$y$j9T$HB1msXB0DEq00J48zRpB20$/3rhVrTzGrv1j/cPvZ0clOM2gEe1TeylUG39wgD0C42";
      extraGroups = [ "wheel" ];
      isNormalUser = true;
      home = "/home/nishir";
    };
    root.initialHashedPassword = "$y$j9T$qvhJXn3EWkRaGuTxeCxhr1$4yUmkSXlSZqH1NcoyvnweX6y1KUv0UUBmEeNskA4JXA";
  };
}
