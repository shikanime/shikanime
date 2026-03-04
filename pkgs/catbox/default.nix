{
  inputs,
  pkgs,
  ...
}:

let
  catbox = inputs.nixpkgs.lib.nixosSystem {
    pkgs = import inputs.nixpkgs {
      inherit (pkgs.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
    modules = [
      ../../hosts/catbox/configuration.nix
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.sharedModules = [
          inputs.devlib.homeManagerModule
        ];
      }
    ];
  };
in
inputs.nix2container.packages.${pkgs.stdenv.hostPlatform.system}.nix2container.buildImage {
  name = "catbox";

  copyToRoot = pkgs.buildEnv {
    name = "root";
    paths = with pkgs; [
      catbox.config.system.build.toplevel
      bash
      coreutils
      dockerTools.binSh
      findutils
      gh
      git
      gnugrep
      gnupg
      gnused
      gnutar
      gzip
      openssh
      pass
      stdenv
    ];
    pathsToLink = [ "/bin" ];
  };

  initializeNixDatabase = true;

  config = {
    Labels = {
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
}
