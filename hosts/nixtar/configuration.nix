{
  config,
  modulesPath,
  pkgs,
  ...
}:

let
  wsl-lib = pkgs.runCommand "wsl-lib" { } ''
    mkdir -p "$out/lib"
    # # we cannot just symlink the lib directory because it breaks merging with other drivers that provide the same directory
    ln -s /usr/lib/wsl/lib/libcudadebugger.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libcuda.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libcuda.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libcuda.so.1.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libd3d12core.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libd3d12.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libdxcore.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvcuvid.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvcuvid.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvdxdlkernels.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvidia-encode.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvidia-encode.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvidia-ml.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvidia-opticalflow.so "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvidia-opticalflow.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvoptix.so.1 "$out/lib"
    ln -s /usr/lib/wsl/lib/libnvwgf2umx.so "$out/lib"
    ln -s /usr/lib/wsl/lib/nvidia-smi "$out/lib"
  '';
in
{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../../modules/nixos/base.nix
    ../../modules/nixos/workstation.nix
  ];

  # Enable cross compilation
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  boot = {
    kernelModules = [ "tcp_bbr" ];

    kernel.sysctl = {
      # Optimize for 64GB RAM
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.max_map_count" = 524288;

      # Increase file watcher limit for IDEs
      "fs.inotify.max_user_watches" = 524288;
      "fs.inotify.max_user_instances" = 512;
      "fs.file-max" = 2097152;

      # Network optimizations
      "net.core.default_qdisc" = "fq";
      "net.core.netdev_max_backlog" = 16384;
      "net.core.rmem_default" = 7340032;
      "net.core.rmem_max" = 16777216;
      "net.core.somaxconn" = 65535;
      "net.core.wmem_default" = 7340032;
      "net.core.wmem_max" = 16777216;
      "net.ipv4.ip_local_port_range" = "1024 65535";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_fin_timeout" = 30;
      "net.ipv4.tcp_keepalive_time" = 600;
      "net.ipv4.tcp_mtu_probing" = 1;
      "net.ipv4.tcp_rmem" = "4096 87380 16777216";
      "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    };
  };

  home-manager.users.shika.imports = [
    ./users/shika/home-configuration.nix
  ];

  # Required for Docker credential management
  environment.systemPackages = [
    pkgs.docker-credential-helpers
    pkgs.wl-clipboard
    pkgs.libnotify
  ];

  # NVIDIA driver is provided by Windows host
  hardware.nvidia.open = false;

  hardware.nvidia-container-toolkit = {
    enable = true;
    mount-nvidia-executables = false;
  };

  networking.hostName = "nixtar";

  nix.extraOptions = ''
    !include ${config.sops.secrets.nix-config.path}
  '';

  programs.nix-ld.libraries = [ wsl-lib ];

  services = {
    gnome.gnome-keyring.enable = true;

    openssh = {
      enable = true;
      openFirewall = true;
    };

    passSecretService.enable = true;

    rke2 = {
      enable = true;
      autoDeployCharts = {
        cert-manager = {
          enable = true;
          createNamespace = true;
          hash = "sha256-9ypyexdJ3zUh56Za9fGFBfk7Vy11iEGJAnCxUDRLK0E=";
          name = "cert-manager";
          repo = "https://charts.jetstack.io";
          targetNamespace = "cert-manager-system";
          values.crds.enabled = true;
          version = "v1.19.1";
        };
        cluster-api-operator = {
          enable = true;
          createNamespace = true;
          hash = "sha256-ROo2PFA39z61PqTpgI2PlTtdIyCG3znHaPgrYPpdA7Q=";
          name = "cluster-api-operator";
          repo = "https://kubernetes-sigs.github.io/cluster-api-operator";
          targetNamespace = "capi-operator-system";
          values.cert-manager.enabled = true;
          version = "0.24.1";
        };
        tailscale-operator = {
          enable = true;
          createNamespace = true;
          hash = "sha256-8pZyWgBTDtnUXnYzDCtbXtTzvUe35BnqHckI/bBuk7o=";
          name = "tailscale-operator";
          repo = "https://pkgs.tailscale.com/helmcharts";
          targetNamespace = "tailscale-system";
          values.operatorConfig.hostname = "nixtar-k8s-operator";
          version = "1.90.9";
        };
        vpa = {
          enable = true;
          createNamespace = true;
          hash = "sha256-d0om1BuSLM9CDIRdmsxeG/uhUfliFmzHe6+qwfXg/t0=";
          name = "vpa";
          repo = "https://charts.fairwinds.com/stable";
          targetNamespace = "kube-system";
          version = "4.10.0";
        };
      };
      cisHardening = true;
      extraFlags = [
        "--cni multus,canal"
        "--cluster-cidr 10.42.0.0/16,2001:cafe:42::/56"
        "--protect-kernel-defaults"
        "--service-cidr 10.43.0.0/16,2001:cafe:43::/112"
        "--tls-san nixtar.taila659a.ts.net"
      ];
      manifests = {
        rke2-canal-config = {
          enable = true;
          content = {
            apiVersion = "helm.cattle.io/v1";
            kind = "HelmChartConfig";
            metadata = {
              name = "rke2-canal";
              namespace = "kube-system";
            };
            spec.valuesContent = builtins.toJSON {
              flannel = {
                iface = "tailscale0";
                backend = "host-gw";
              };
            };
          };
        };
        rke2-multus-config = {
          enable = true;
          content = {
            apiVersion = "helm.cattle.io/v1";
            kind = "HelmChartConfig";
            metadata = {
              name = "rke2-multus";
              namespace = "kube-system";
            };
            spec.valuesContent = builtins.toJSON {
              thickPlugin.enabled = true;
              dynamicNetworksController.enabled = true;
            };
          };
        };
      };
      nodeIP = "100.111.162.12,fd7a:115c:a1e0::2101:1963";
      role = "server";
    };

    tailscale = {
      enable = true;
      openFirewall = true;
      authKeyFile = config.sops.secrets.tailscale-authkey.path;
      extraUpFlags = [
        "--advertise-routes 10.42.0.0/16,2001:cafe:42::/56"
        "--ssh"
      ];
      useRoutingFeatures = "both";
    };

    xserver.videoDrivers = [ "nvidia" ];
  };

  sops = {
    age = {
      generateKey = true;
      keyFile = "/var/lib/spos-nix/key.txt";
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
    defaultSopsFile = ../../secrets/nixtar.enc.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      nix-config = { };
      tailscale-authkey = { };
      tailscale-operator-config-manifest = { };
    };
  };

  users.users.shika = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/shika";
  };

  # Docker CDI setting is not enabled by default
  virtualisation.docker.rootless.daemon.settings.features.cdi = true;

  wsl = {
    enable = true;
    defaultUser = "shika";
    interop.register = true;
    useWindowsDriver = true;
    wslConf.network = {
      generateHosts = false;
      generateResolvConf = false;
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /var/lib/rancher/rke2/server/manifests/tailscale-operator-config.yaml - - - - ${config.sops.secrets.tailscale-operator-config-manifest.path}"
  ];
}
