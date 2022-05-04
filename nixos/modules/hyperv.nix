{
  # Resize Hyper-V default disk size
  hyperv.baseImageSize = 64 * 1024;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "auto";
  };
}
