{ modulesPath, pkgs, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../../modules/nixos/base.nix
    ../../modules/nixos/workstation.nix
    ../../modules/nixos/wsl.nix
  ];

  home-manager.users.nishir.imports = [
    ./users/shika/home-configuration.nix
  ];

  networking.hostName = "nixtar";

  users.users.shika = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "wheel"
    ];
    home = "/home/shika";
    shell = pkgs.fish;
  };

  wsl.defaultUser = "shika";
}
