{ pkgs, nixosConfiguration, ... }:

pkgs.dockerTools.streamLayeredImage {
  name = "ghcr.io/shikanime/shikanime/devcontainer";
  contents = [
    nixosConfiguration.config.system.build.toplevel
    pkgs.coreutils
    pkgs.git
    pkgs.gnugrep
    pkgs.gnused
    pkgs.gnutar
    pkgs.gzip
    pkgs.stdenv
    pkgs.dockerTools.binSh
    pkgs.dockerTools.caCertificates
    pkgs.dockerTools.fakeNss
    pkgs.dockerTools.usrBinEnv
  ];
  includeNixDB = true;
  config = {
    LABELS = {
      "devcontainer.metadata" = builtins.toJSON [
        {
          overrideCommand = false;
          privileged = true;
          remoteUser = "vscode";
          updateRemoteUserUID = true;
        }
      ];
    };
    Entrypoint = [ "/init" ];
    SHELL = [ "/run/current-system/sw/bin/bash" ];
  };
}
