{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../users/nixos.nix
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;

  boot.kernelParams = [
    "8250.nr_uarts=1"
    "console=ttyAMA0,115200"
    "console=tty1"
    "cma=128M"
    "cgroup_enable=cpuset"
    "cgroup_enable=memory"
    "cgroup_memory=1"
  ];

  hardware.raspberry-pi."4" = {
    fkms-3d.enable = true;
    apply-overlays-dtmerge.enable = true;
  };

  # https://github.com/NixOS/nixpkgs/issues/154163#issuecomment-1008362877
  nixpkgs.overlays = [
    (_: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  # Enable Wake-on-LAN on the ethernet port
  networking.interfaces.eth0.wakeOnLan.enable = true;

  # This is required so that pod can reach the API server (running on port 6443 by default)
  networking.firewall.allowedTCPPorts = [ 6443 ];

  # Enable Kubernetes
  services.k3s = {
    enable = true;
    role = "server";
  };

  # Enable YubiKey support
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # Enable disk auto-mounting
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Add wireless service
  networking.wireless.enable = true;

  # Set up wireless access point
  services.hostapd = {
    enable = true;
    radios = {
      # Simple 2.4GHz AP
      wlp2s0 = {
        networks.wlp2s0 = {
          ssid = "Vintage Korean 2.4GHz";
          authentication.saePasswords = [{ password = "6P6d&8WmYH!rvv"; }];
        };
      };

      # WiFi 5 (5GHz) with two advertised networks
      wlp3s0 = {
        band = "5g";
        # Enable automatic channel selection (ACS)
        networks.wlp3s0 = {
          ssid = "Vintage Korean";
          authentication.saePasswords = [{ password = "6P6d&8WmYH!rvv"; }];
        };
      };
    };
  };

  # Bridge ethernet and wifi
  networking.bridges.br0.interfaces = [ "eth0" "wlp2s0" "wlp3s0" ];

  networking.hostName = "nishir";
}
