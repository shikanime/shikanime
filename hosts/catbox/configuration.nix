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
      pkgs.docker
      pkgs.dockerTools.binSh
      pkgs.findutils
      pkgs.gh
      pkgs.git
      pkgs.gnugrep
      pkgs.gnupg
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

  users.users = {
    root.initialHashedPassword = "$y$j9T$YiuBBsevFD1c6mAOGSJrj/$F74aClFmbKOt/qXs//kaWzFgJbS8JU8GciGb7ocdOi0";
    shika = {
      initialHashedPassword = "$y$j9T$HB1msXB0DEq00J48zRpB20$/3rhVrTzGrv1j/cPvZ0clOM2gEe1TeylUG39wgD0C42";
      extraGroups = [ "wheel" ];
      isNormalUser = true;
      home = "/home/shika";
    };
  };
}
