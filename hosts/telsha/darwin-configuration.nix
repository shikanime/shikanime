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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDsUrtJU0kAg39S6Is4hOhiCIbZusi7/MHAvLYY0M7L3 shikanimedeva@kaltashar"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIciZH796Ca2/OgnDrxsnyAeuuiaT9Yvc6hH9cXWARoH shikanimedeva@telsha"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRmTkC8sHNFKpHFfbSsZAQ5/gJyUlgUCXOhYhjPmNed shika@ishtar"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINql3Q+6f6EM8ZBIFPOnVzbxsU1jOhAFRg+3Y8oSKy5s shika@nixtar"
    ];
  };
}
