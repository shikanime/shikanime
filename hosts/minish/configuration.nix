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

  boot = {
    # Enable cgroup for Kubernetes
    kernelParams = [
      "cgroup_enable=cpuset"
      "cgroup_enable=memory"
      "cgroup_memory=1"
    ];

    kernel.sysctl = {
      # Allow many inotify instances for controllers and Syncthing
      "fs.inotify.max_user_instances" = 8192;
      # Allow many watched paths for large libraries (Syncthing/copyparty)
      "fs.inotify.max_user_watches" = 524288;
      # Raise system-wide open files to prevent global exhaustion
      "fs.file-max" = 2097152;
      # Increase conntrack capacity for Kubernetes NAT
      "net.netfilter.nf_conntrack_max" = 262144;
      # Fair queuing qdisc; synergizes with BBR
      "net.core.default_qdisc" = "fq";
      # Increase ingress backlog for bursty overlay traffic (Calico/Tailscale)
      "net.core.netdev_max_backlog" = 16384;
      # Allow larger autotuned receive buffers
      "net.core.rmem_max" = 16777216;
      # Increase accept backlog for busy services (Jellyfin/copyparty)
      "net.core.somaxconn" = 65535;
      # Raise default socket send buffer
      "net.core.wmem_default" = 7340032;
      # Allow larger autotuned send buffers
      "net.core.wmem_max" = 16777216;
      # Enable IPv4 forwarding for Kubernetes/overlay networking
      "net.ipv4.ip_forward" = 1;
      # Relax rp_filter for asymmetric routing via Tailscale subnet router
      "net.ipv4.conf.all.rp_filter" = 0;
      "net.ipv4.conf.default.rp_filter" = 0;
      "net.ipv4.conf.tailscale0.rp_filter" = 0;
      # Widen ephemeral port range to avoid exhaustion
      "net.ipv4.ip_local_port_range" = "1024 65535";
      # BBR congestion control for better throughput/latency
      "net.ipv4.tcp_congestion_control" = "bbr";
      # Free sockets sooner under load
      "net.ipv4.tcp_fin_timeout" = 30;
      # Maintain long-lived connections without frequent probes
      "net.ipv4.tcp_keepalive_time" = 600;
      # Enable PMTU probing for overlays/Tailnet
      "net.ipv4.tcp_mtu_probing" = 1;
      # Expand TCP autotuning bounds (recv)
      "net.ipv4.tcp_rmem" = "4096 87380 16777216";
      # Expand TCP autotuning bounds (send)
      "net.ipv4.tcp_wmem" = "4096 65536 16777216";
      # SATA SSD: background writeback tuned for balanced IO
      "vm.dirty_background_ratio" = 5;
      # SATA SSD: expire dirty data moderately for merges (15s)
      "vm.dirty_expire_centisecs" = 1500;
      # SATA SSD: limit dirty pages to reduce IO spikes
      "vm.dirty_ratio" = 15;
      # SATA SSD: writeback cadence (5s)
      "vm.dirty_writeback_centisecs" = 500;
      # Support many mmap/large indices/filesystems
      "vm.max_map_count" = 262144;
      # Prefer page cache, avoid swap thrash
      "vm.swappiness" = 10;
      # Favor inode/dentry caching for large media libraries
      "vm.vfs_cache_pressure" = 50;
    };
  };

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
      kubelet = {
        extraOpts = "--fail-swap-on=false";
        kubeconfig.server = "https://nishir.taila659a.ts.net:6443";
      };
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

  users.users.nishir = {
    initialHashedPassword = "$y$j9T$HB1msXB0DEq00J48zRpB20$/3rhVrTzGrv1j/cPvZ0clOM2gEe1TeylUG39wgD0C42";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    home = "/home/nishir";
  };
}
