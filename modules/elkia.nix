{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/virtualisation/vmware-image.nix"
  ];

  # Define network name
  networking.hostName = "elkia";
}
