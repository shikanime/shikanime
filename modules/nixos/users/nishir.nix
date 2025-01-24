{
  users.users.nishir = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/nishir";
    useDefaultShell = true;
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
