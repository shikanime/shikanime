{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-raspberrypi-installer.nix"
    ../users/nishir.nix
  ];
}
