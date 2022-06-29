{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/virtualisation/hyperv-image.nix"
  ];

  # Resize Hyper-V default disk size
  hyperv.baseImageSize = 64 * 1024;
}
