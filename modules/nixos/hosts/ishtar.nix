{ pkgs, ... }:

{
  imports = [
    ../profiles/base.nix
  ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  users.users.shika = {
    isNormalUser = true;
    home = "/home/shika";
    shell = pkgs.nushell;
    useDefaultShell = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.shika.imports = [
    ../../home/hosts/ishtar-shika.nix
    ../../home/identities/shikanime.nix
  ];

  hardware = {
    nvidia.open = true;
    nvidia-container-toolkit.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.nix-ld.enable = true;

  networking.hostName = "ishtar";

  services.xserver.videoDrivers = [ "intel" "nvidia" ];

  virtualisation.docker.enable = true;

  wsl = {
    enable = true;
    defaultUser = "shika";
    useWindowsDriver = true;
    interop.register = true;
    usbip.enable = true;
  };
}
