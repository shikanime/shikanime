{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../users/shika.nix
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

  # This is required so that pod can reach the API server (running on port 6443 by default)
  networking.firewall.allowedTCPPorts = [ 6443 ];

  # Enable Kubernetes
  services.k3s = {
    enable = true;
    role = "server";
  };

  # Longhorn requires open-iscsi
  services.openiscsi = {
    enable = true;
    name = "iqn.2024-04.studio.shikanime:nishir";
  };

  # Enable cross platform build
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking.hostName = "nishir";
}
