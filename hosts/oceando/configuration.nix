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
    ../../modules/nixos/machine.nix
    ../../modules/nixos/workstation.nix
  ];

  home-manager.users.shika.imports = [
    ./users/shika/home-configuration.nix
  ];

  # Let Docker manage /etc/resolv.conf
  environment.etc."resolv.conf".enable = false;

  security.sudo.wheelNeedsPassword = false;

  system.build.streamLayeredImage = pkgs.dockerTools.streamLayeredImage {
    name = "ghcr.io/shikanime/shikanime/oceando";
    contents = [
      config.system.build.toplevel
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
              }
              {
                source = "/sys/kernel/tracing";
                target = "/sys/kernel/tracing";
              }
            ];
            overrideCommand = false;
            privileged = true;
            remoteUser = "shika";
            updateRemoteUserUID = false;
          }
        ];
        "org.opencontainers.image.source" = "https://github.com/shikanime/shikanime";
        "org.opencontainers.image.description" = "Oceando development environment";
        "org.opencontainers.image.licenses" = "AGPL-3.0-or-later";
      };
      ExposedPorts = {
        "22/tcp" = { };
        "5353/udp" = { };
      };
      Entrypoint = [ "/init" ];
    };
  };

  systemd.tmpfiles.rules = [
    "Z /workspaces - shika users - -"
  ];

  users.users.shika = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/shika";
  };
}
