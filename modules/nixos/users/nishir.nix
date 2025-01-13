{
  users.users.nishir = {
    isNormalUser = true;
    home = "/home/nishir";
    useDefaultShell = true;
    extraGroups = [ "wheel" ];
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
