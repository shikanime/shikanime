{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/virtualisation/hyperv-image.nix"
  ];

  # Resize Hyper-V default disk size
  hyperv.baseImageSize = 64 * 1024;

  networking.hostName = "elvengard";
}
