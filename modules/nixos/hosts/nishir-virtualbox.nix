{ pkgs, lib, modulesPath, ... }:

with lib;

{
  imports = [
    "${modulesPath}/virtualisation/virtualbox-image.nix"
    ./nishir-base.nix
  ];

  virtualisation.virtualbox.guest.enable = mkForce false;
}
