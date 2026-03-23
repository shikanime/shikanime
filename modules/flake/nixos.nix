{ inputs, ... }:
_:

{
  flake = {
    nixosConfigurations = {
      fushi = inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/fushi/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          inputs.sops-nix.nixosModules.sops
          {
            home-manager.sharedModules = [
              inputs.devlib.homeManagerModule
              inputs.sops-nix.homeManagerModule
            ];
          }
        ];
      };
      minish = inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/minish/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          inputs.sops-nix.nixosModules.sops
          {
            home-manager.sharedModules = [
              inputs.devlib.homeManagerModule
              inputs.sops-nix.homeManagerModule
            ];
          }
        ];
      };
      nishir = inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/nishir/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.raspberry-pi-5
          inputs.sops-nix.nixosModules.sops
          {
            home-manager.sharedModules = [
              inputs.devlib.homeManagerModule
              inputs.sops-nix.homeManagerModule
            ];
          }
        ];
      };
      nixtar = inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/nixtar/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-wsl.nixosModules.default
          inputs.sops-nix.nixosModules.sops
          {
            home-manager.sharedModules = [
              inputs.devlib.homeManagerModule
              inputs.sops-nix.homeManagerModule
            ];
          }
        ];
      };
    };

    packages =
      let
        catbox-image =
          _system: pkgs:
          let
            catbox = inputs.nixpkgs.lib.nixosSystem {
              inherit pkgs;
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
          pkgs.dockerTools.buildLayeredImage {
            name = "ghcr.io/shikanime/shikanime/catbox";
            fromImage = pkgs.dockerTools.pullImage {
              imageName = "qemux/qemu";
              imageDigest = "sha256:26692176202c65d7b32de836534e1fb03a9650b6271403299646bf5375334557";
              sha256 = "0k5c95dsf124s2a2qj3nx3h3z4x3s3y3z3x3s3y3z3x3s3y3z3x3";
              finalImageTag = "latest";
            };
            contents = [ catbox.config.system.build.image ];
            config = {
              Entrypoint = [
                "/bin/sh"
                "-c"
                "cp /image /boot.img && /entrypoint.sh"
              ];
            };
          };
      in
      {
        x86_64-linux.catbox = catbox-image "x86_64-linux" (
          import inputs.nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          }
        );
        aarch64-linux.catbox = catbox-image "aarch64-linux" (
          import inputs.nixpkgs {
            system = "aarch64-linux";
            config.allowUnfree = true;
          }
        );
      };
  };
}
