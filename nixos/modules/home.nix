{ pkgs ? import <nixpkgs> { }, ... }:

{
  # Create user accounts
  users.users.devas = {
    isNormalUser = true;
    home = "/home/devas";
    extraGroups = [ "docker" "wheel" "libvirt" "vboxsf" "vboxusers" ];
    shell = pkgs.zsh;
    hashedPassword = "$6$YS5jCyZU2Z6i05wm$jFsx9fnINawEk2Vd5uZBdR71sOBHHgANUEBsp93fG3scp2uui3kYhzXh9c4eC4ZdHKq48//IWE00JwZ.ez.lg.";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7pi5OYqzuMkTymIbJUJteIU3dz+OgduiF5O9cA+B7u devas@ishtar"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFChPMDHee+8F8tuchk8nLqdzVj1SOfLFv70NH95K6Yf williamphetsinorath@altashar"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.devas = import ../../nixpkgs/home.nix;
  };
}
