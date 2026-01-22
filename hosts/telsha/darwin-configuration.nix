{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ../../modules/darwin/base.nix
    ../../modules/darwin/workstation.nix
  ];

  home-manager.users.shikanimedeva.imports = [
    ./users/shikanimedeva/home-configuration.nix
  ];

  # FIX: https://github.com/Mic92/sops-nix/issues/890
  launchd.agents.sops-nix = mkIf pkgs.stdenv.isDarwin {
    enable = true;
    config.EnvironmentVariables.PATH = mkForce "/usr/bin:/bin:/usr/sbin:/sbin";
  };

  networking.hostName = "telsha";

  nix.extraOptions = ''
    !include ${config.sops.secrets.nix-config.path}
  '';

  sops = {
    age = {
      generateKey = true;
      keyFile = "/var/lib/sops-nix/key.txt";
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
    defaultSopsFile = ../../secrets/telsha.enc.yaml;
    defaultSopsFormat = "yaml";
    secrets.nix-config = { };
  };

  system.primaryUser = "shikanimedeva";

  users.users.shikanimedeva = {
    name = "shikanimedeva";
    home = "/Users/shikanimedeva";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+tp1Xfz7NomHCZuDPlfj3XW5hm9t0TiCyEeudRraoe"
    ];
  };
}
