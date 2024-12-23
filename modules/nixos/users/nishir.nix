{
  users.users.nishir = {
    isNormalUser = true;
    home = "/home/nishir";
    useDefaultShell = true;
    extraGroups = [ "wheel" ];
    initialHashedPassword = "$y$j9T$HB1msXB0DEq00J48zRpB20$/3rhVrTzGrv1j/cPvZ0clOM2gEe1TeylUG39wgD0C42";
  };

  home-manager.users.nishir = {
    imports = [
      ../../home/profiles/base.nix
    ];

    home = {
      homeDirectory = "/home/nishir";
      username = "nishir";
    };
  };
}
