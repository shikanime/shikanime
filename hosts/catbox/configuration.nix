{
  config,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/virtualisation/docker-image.nix"
    ../../modules/nixos/base.nix
    ../../modules/nixos/workstation.nix
  ];

  home-manager.users.shika.imports = [
    ./users/shika/home-configuration.nix
  ];

  # Let Docker manage /etc/resolv.conf
  environment.etc."resolv.conf".enable = false;

  programs.nix-ld.enable = true;

  security.sudo.wheelNeedsPassword = false;

  # Enable SSH access
  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  system.build.streamLayeredImage = pkgs.dockerTools.streamLayeredImage {
    name = "ghcr.io/shikanime/shikanime/catbox";
    contents = [
      config.system.build.toplevel
      pkgs.bash
      pkgs.coreutils
      pkgs.dockerTools.binSh
      pkgs.git
      pkgs.gnugrep
      pkgs.gnused
      pkgs.gnutar
      pkgs.gzip
      pkgs.stdenv
    ];
    includeNixDB = true;
    config = {
      LABELS = {
        "devcontainer.metadata" = builtins.toJSON [
          {
            containerEnv = {
              USER = "shika";
            };
            mounts = [
              {
                source = "/sys/kernel/debug";
                target = "/sys/kernel/debug";
                type = "bind";
              }
              {
                source = "/sys/kernel/tracing";
                target = "/sys/kernel/tracing";
                type = "bind";
              }
            ];
            overrideCommand = false;
            privileged = true;
            remoteUser = "shika";
            runArgs = [
              "--interactive"
              "--tty"
            ];
            updateRemoteUserUID = false;
          }
        ];
        "org.opencontainers.image.source" = "https://github.com/shikanime/shikanime";
        "org.opencontainers.image.description" = "catbox development environment";
        "org.opencontainers.image.licenses" = "AGPL-3.0-or-later";
      };
      ExposedPorts."22/tcp" = { };
      Entrypoint = [ "/init" ];
    };
  };

  systemd.tmpfiles.rules = [
    "Z /workspaces - shika users - -"
  ];

  users.users.shika = {
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    home = "/home/shika";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDsUrtJU0kAg39S6Is4hOhiCIbZusi7/MHAvLYY0M7L3 shikanimedeva@kaltashar"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIciZH796Ca2/OgnDrxsnyAeuuiaT9Yvc6hH9cXWARoH shikanimedeva@telsha"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRmTkC8sHNFKpHFfbSsZAQ5/gJyUlgUCXOhYhjPmNed shika@ishtar"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINql3Q+6f6EM8ZBIFPOnVzbxsU1jOhAFRg+3Y8oSKy5s shika@nixtar"
    ];
  };
}
