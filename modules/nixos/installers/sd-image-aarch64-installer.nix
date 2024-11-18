{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64-installer.nix"
    ../users/nishir.nix
  ];
}
