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
    openssh = {
      enable = true;
      openFirewall = true;
    };

    gnome.gnome-keyring.enable = true;

    passSecretService.enable = true;

    xserver.videoDrivers = [ "nvidia" ];
  };

  systemd.network.enable = true;

  sops = {
    age = {
      generateKey = true;
      keyFile = "/var/lib/spos-nix/key.txt";
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
    defaultSopsFile = ../../secrets/nixtar.enc.yaml;
    defaultSopsFormat = "yaml";
    secrets.nix-config = { };
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
  };
}
