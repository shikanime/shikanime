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
  imports = [
    ../profiles/base.nix
  ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  programs.zsh.enable = true;

  users.users.shika = {
    isNormalUser = true;
    home = "/home/shika";
    shell = pkgs.zsh;
    useDefaultShell = true;
    extraGroups = [ "docker" "wheel" ];
  };

  home-manager.users.shika.imports = [
    ../../home/hosts/ishtar-shika.nix
    ../../home/identities/shikanime.nix
  ];

  hardware = {
    nvidia.open = false;
    nvidia-container-toolkit.enable = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = [ wsl-lib ];
  };

  networking.hostName = "ishtar";

  services.xserver.videoDrivers = [ "intel" "nvidia" ];

  virtualisation.docker = {
    enable = true;
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
