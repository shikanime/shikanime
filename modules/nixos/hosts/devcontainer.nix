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

  system.activationScripts.installBinShScript = ''
    ln -fs ${pkgs.bashInteractive}/bin/sh /bin/sh
  '';

  system.build.dockerImage = pkgs.dockerTools.buildImage {
    name = "ghcr.io/shikanime/shikanime/devcontainer";
    tag = "latest";
    created = "now";
    copyToRoot = config.system.build.toplevel;
    includeNixDB = true;
    config = {
      Entrypoint = [ "/init" ];
      SHELL = [ "/run/current-system/sw/bin/bash" ];
    };
  };
}
