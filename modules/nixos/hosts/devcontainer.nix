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
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../users/vscode.nix
  ];

  security.sudo.wheelNeedsPassword = false;

  services.getty.autologinUser = "root";

  system.build.dockerImage = pkgs.dockerTools.buildLayeredImage {
    name = "ghcr.io/shikanime/shikanime/devcontainer";
    tag = "latest";
    created = "now";
    contents = [
      config.system.build.toplevel
      pkgs.coreutils
      pkgs.dockerTools.binSh
      pkgs.dockerTools.caCertificates
      pkgs.dockerTools.fakeNss
      pkgs.dockerTools.usrBinEnv
      pkgs.git
      pkgs.gnugrep
      pkgs.gnused
      pkgs.gnutar
      pkgs.gzip
    ];
    includeNixDB = true;
    config = {
      Entrypoint = [ "/init" ];
      User = "vscode";
      SHELL = [ "/run/current-system/sw/bin/bash" ];
    };
  };
}
