{ pkgs, lib, modulesPath, ... }:

with lib;

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../profiles/k3s.nix
    ../users/shika.nix
  ];
}
