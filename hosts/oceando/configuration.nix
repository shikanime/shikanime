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
            overrideCommand = false;
            privileged = true;
            remoteUser = "shika";
            updateRemoteUserUID = false;
          }
        ];
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
