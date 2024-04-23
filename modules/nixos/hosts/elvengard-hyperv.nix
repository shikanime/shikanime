{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/virtualisation/hyperv-image.nix"
    ./elvengard-base.nix
  ];

  # Resize Hyper-V default disk size
  hyperv.baseImageSize = 64 * 1024;
}
