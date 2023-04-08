{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/virtualisation/hyperv-image.nix"
  ];

  # Configure Home Manager to use NixOS global packages
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # Resize Hyper-V default disk size
  hyperv.baseImageSize = 64 * 1024;

  # Enable the Bonjour protocol for local network discovery
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Enable Network Time Protocol
  services.ntp.enable = true;

  networking.hostName = "elvengard";
}
