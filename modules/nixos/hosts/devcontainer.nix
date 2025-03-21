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
      SHELL = [ "/run/current-system/sw/bin/bash" ];
    };
  };
}
