{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/virtualisation/virtualbox-image.nix"
  ];

  # Define network name
  networking.hostName = "elkia";
}
