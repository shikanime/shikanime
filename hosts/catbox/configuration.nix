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

  programs.nix-ld = {
    enable = true;
    libraries = [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  services = {
    gnome.gnome-keyring.enable = true;

    passSecretService.enable = true;

    # Enable SSH access
    openssh = {
      enable = true;
      openFirewall = true;
    };
  };

  system.build.streamLayeredImage = pkgs.dockerTools.streamLayeredImage {
    name = "ghcr.io/shikanime/shikanime/catbox";
    contents = [
      config.system.build.toplevel
      pkgs.bash
      pkgs.coreutils
      pkgs.docker
      pkgs.docker-credential-helpers
      pkgs.dockerTools.binSh
      pkgs.findutils
      pkgs.gh
      pkgs.git
      pkgs.gnugrep
      pkgs.gnupg
      pkgs.gnused
      pkgs.gnutar
      pkgs.gzip
      pkgs.openssh
      pkgs.pass
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
            onCreateCommand = "systemctl is-system-running --wait || true";
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

  users.users.shika = {
    extraGroups = [ "wheel" ];
    initialHashedPassword = "";
    isNormalUser = true;
    home = "/home/shika";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+tp1Xfz7NomHCZuDPlfj3XW5hm9t0TiCyEeudRraoe"
    ];
  };

  virtualisation.docker = {
    autoPrune.enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
