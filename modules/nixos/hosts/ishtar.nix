{ pkgs, ... }:

{
  imports = [
    ../profiles/base.nix
  ];

  users.users.shika = {
    isNormalUser = true;
    home = "/home/shika";
    shell = pkgs.nushell;
    useDefaultShell = true;
    initialHashedPassword = "";
    extraGroups = [ "wheel" ];
  };

  home-manager.users.shika.imports = [
    ../../home/hosts/ishtar-shika.nix
    ../../home/identities/shikanime.nix
  ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  programs.nix-ld.enable = true;

  networking.hostName = "ishtar";

  wsl = {
    enable = true;
    defaultUser = "shika";
    useWindowsDriver = true;
    docker-desktop.enable = true;
    interop.register = true;
    usbip.enable = true;
  };
}
