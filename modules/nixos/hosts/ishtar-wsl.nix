{
  imports = [
    ../ishtar-base.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "shika";
    useWindowsDriver = true;
    docker-desktop.enable = true;
    interop.register = true;
    usbip.enable = true;
  };
}
