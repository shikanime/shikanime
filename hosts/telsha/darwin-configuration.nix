{ config, ... }:

{
  imports = [
    ../../modules/darwin/base.nix
    ../../modules/darwin/workstation.nix
  ];

  home-manager.users.shikanimedeva.imports = [
    ./users/shikanimedeva/home-configuration.nix
  ];

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
  };
}
