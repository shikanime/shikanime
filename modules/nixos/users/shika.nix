{
  # Create user accounts
  users.users.shika = {
    isNormalUser = true;
    home = "/home/shika";
    extraGroups = [ "wheel" ];
    initialHashedPassword = "$y$j9T$HB1msXB0DEq00J48zRpB20$/3rhVrTzGrv1j/cPvZ0clOM2gEe1TeylUG39wgD0C42";
  };

  # Configure user home
  home-manager.users.shika.imports = [
    ../../home/hosts/nishir-shika.nix
  ];
}
