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

  home-manager.users.vscode.imports = [
    ./users/vscode/home-configuration.nix
  ];

  # Let Docker manage /etc/resolv.conf
  environment.etc."resolv.conf".enable = false;

  security.sudo.wheelNeedsPassword = false;

  system.build.streamLayeredImage = pkgs.dockerTools.streamLayeredImage {
    name = "ghcr.io/shikanime/shikanime/devcontainer";
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
            overrideCommand = false;
            privileged = true;
            containerEnv = {
              USER = "vscode";
            };
            remoteUser = "vscode";
            updateRemoteUserUID = false;
          }
        ];
      };
      Entrypoint = [ "/init" ];
    };
  };

  systemd.tmpfiles.rules = [
    "Z /workspaces - vscode users - -"
  ];

  users.users.vscode = {
    initialHashedPassword = "";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/shika";
  };
}
