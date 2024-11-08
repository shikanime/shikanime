{ pkgs, ... }:

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
  # Required for Docker credential management
  environment.systemPackages = [
    pkgs.docker-credential-helpers
  ];

  # Enable accelerator
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

  # Common configuration on a Raspberry Pi 4
  boot.kernelParams = [
    "8250.nr_uarts=1"
    "console=ttyAMA0,115200"
    "console=tty1"
    "cma=128M"
  ];

  # Enable cross compilation
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  # Enable Nvidia Docker integration
  hardware = {
    nvidia.open = false;
    nvidia-container-toolkit = {
      enable = true;
      mount-nvidia-executables = false;
    };
  };

  # Docker need a secret manager
  services.passSecretService.enable = true;

  # Enable WSLg integration
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    videoDrivers = [ "intel" "nvidia" ];
  };

  programs.zsh.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = [ wsl-lib ];
  };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    daemon.settings.features.cdi = true;
  };

  wsl = {
    enable = true;
    defaultUser = "shika";
    useWindowsDriver = true;
    interop.register = true;
    usbip.enable = true;
  };
}
