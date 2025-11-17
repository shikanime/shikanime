{ inputs, ... }:

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

    packages = {
      x86_64-linux.catbox =
        let
          catbox = inputs.nixpkgs.lib.nixosSystem {
            pkgs = import inputs.nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
            modules = [
              ../../hosts/catbox/configuration.nix
              inputs.home-manager.nixosModules.home-manager
            ];
          };
        in
        catbox.config.system.build.streamLayeredImage;
      aarch64-linux.catbox =
        let
          catbox = inputs.nixpkgs.lib.nixosSystem {
            pkgs = import inputs.nixpkgs {
              system = "aarch64-linux";
              config.allowUnfree = true;
            };
            modules = [
              ../../hosts/catbox/configuration.nix
              inputs.home-manager.nixosModules.home-manager
            ];
          };
        in
        catbox.config.system.build.streamLayeredImage;
    };
  };
}
