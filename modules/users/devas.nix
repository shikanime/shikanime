{ pkgs ? import <nixpkgs> { }, ... }:

{
  # Create user accounts
  users.users.devas = {
    isNormalUser = true;
    home = "/home/devas";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = "$6$YS5jCyZU2Z6i05wm$jFsx9fnINawEk2Vd5uZBdR71sOBHHgANUEBsp93fG3scp2uui3kYhzXh9c4eC4ZdHKq48//IWE00JwZ.ez.lg.";
  };

  # Configure user home
  home-manager.users.devas = import ../../homes/devenv.nix {
    inherit pkgs;
  };
}
