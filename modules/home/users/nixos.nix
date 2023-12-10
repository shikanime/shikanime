{
  imports = [
    ../profiles/base.nix
  ];

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
  };

  home.homeDirectory = "/home/nixos";
  home.username = "nixos";
}
