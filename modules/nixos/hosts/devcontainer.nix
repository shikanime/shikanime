{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/virtualisation/docker-image.nix"
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../users/shika.nix
  ];

  networking.hostName = "devcontainer";
}
