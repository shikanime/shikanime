{ pkgs, ... }:

{
  users.users.shika = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "wheel"
    ];
    home = "/home/shika";
    shell = pkgs.zsh;
  };

  home-manager.users.shika = {
    imports = [
      ../../home/profiles/base.nix
      ../../home/profiles/beam.nix
      ../../home/profiles/cloud.nix
      ../../home/profiles/go.nix
      ../../home/profiles/helix.nix
      ../../home/profiles/ishtar.nix
      ../../home/profiles/java.nix
      ../../home/profiles/javascript.nix
      ../../home/profiles/python.nix
      ../../home/profiles/rustup.nix
      ../../home/profiles/unix.nix
      ../../home/profiles/vcs.nix
      ../../home/profiles/workstation.nix
    ];

    home = {
      homeDirectory = "/home/shika";
      username = "shika";
    };
  };
}
