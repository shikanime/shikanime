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
  # Enable cross compilation
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  # Browser open support
  environment.sessionVariables.BROWSER = "${pkgs.wslu}/bin/wslview";

  # Required for Docker credential management
  environment.systemPackages = [
    pkgs.wslu
    pkgs.docker-credential-helpers
  ];

  # Enable Nvidia Docker integration
  hardware = {
    nvidia.open = false;
    nvidia-container-toolkit = {
      enable = true;
      mount-nvidia-executables = false;
    };
  };

  programs.nix-ld.libraries = [ wsl-lib ];

  # Docker need a secret manager
  services.gnome.gnome-keyring.enable = true;
  services.passSecretService.enable = true;

  # Enable WSLg integration
  services.xserver.videoDrivers = [
    "intel"
    "nvidia"
  ];

  virtualisation.docker.daemon.settings.features.cdi = true;

  wsl = {
    enable = true;
    useWindowsDriver = true;
    interop.register = true;
  };
}
