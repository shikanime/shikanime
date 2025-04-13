{ pkgs, nixosConfiguration, ... }:

pkgs.dockerTools.buildLayeredImage {
  name = "ghcr.io/shikanime/shikanime/devcontainer";
  tag = "latest";
  created = "now";
  copyToRoot = pkgs.buildEnv {
    name = "oceando-image-root";
    paths = [
      nixosConfiguration.config.system.build.tarball
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
    pathsToLink = [ "/bin" ];
  };
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
    SHELL = [ "/run/current-system/sw/bin/fish" ];
  };
}
