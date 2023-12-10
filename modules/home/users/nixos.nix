{
  imports = [
    ../profiles/base.nix
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    defaultCacheTtl = 4 * 60 * 60;
    pinentryFlavor = "tty";
  };

  home.homeDirectory = "/home/nixos";
  home.username = "nixos";
}
