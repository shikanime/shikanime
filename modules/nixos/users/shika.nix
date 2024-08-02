{
  # Create user accounts
  users.users.shika = {
    isNormalUser = true;
    home = "/home/shika";
    extraGroups = [ "wheel" ];
    initialHashedPassword = "$y$j9T$HB1msXB0DEq00J48zRpB20$/3rhVrTzGrv1j/cPvZ0clOM2gEe1TeylUG39wgD0C42";
  };

  # Configure user home
  home-manager.users.shika = {
    imports = [
      ../../home/identities/shikanime.nix
      ../../home/profiles/base.nix
    ];

    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableExtraSocket = true;
    };

    home.homeDirectory = "/home/shika";
    home.username = "shika";
  };
}
