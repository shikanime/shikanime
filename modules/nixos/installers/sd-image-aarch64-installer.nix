{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../users/nishir.nix
  ];

  security.sudo.wheelNeedsPassword = false;

  networking.hostName = "nixos";
}
