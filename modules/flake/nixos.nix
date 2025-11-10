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
          inputs.identities.nixosModules.fushi
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          inputs.sops-nix.nixosModules.sops
          { home-manager.sharedModules = [ inputs.devlib.homeManagerModule ]; }
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
          inputs.identities.nixosModules.minish
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          inputs.sops-nix.nixosModules.sops
          { home-manager.sharedModules = [ inputs.devlib.homeManagerModule ]; }
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
          inputs.identities.nixosModules.nishir
          inputs.nixos-hardware.nixosModules.raspberry-pi-5
          inputs.sops-nix.nixosModules.sops
          { home-manager.sharedModules = [ inputs.devlib.homeManagerModule ]; }
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
          inputs.identities.nixosModules.nixtar
          inputs.nixos-wsl.nixosModules.default
          inputs.sops-nix.nixosModules.sops
          { home-manager.sharedModules = [ inputs.devlib.homeManagerModule ]; }
        ];
      };
    };

    packages = {
      x86_64-linux.oceando =
        let
          oceando = inputs.nixpkgs.lib.nixosSystem {
            pkgs = import inputs.nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
            modules = [
              ../../hosts/oceando/configuration.nix
              inputs.home-manager.nixosModules.home-manager
              inputs.identities.nixosModules.oceando
              inputs.sops-nix.nixosModules.sops
              { home-manager.sharedModules = [ inputs.devlib.homeManagerModule ]; }
            ];
          };
        in
        oceando.config.system.build.streamLayeredImage;
      aarch64-linux.oceando =
        let
          oceando = inputs.nixpkgs.lib.nixosSystem {
            pkgs = import inputs.nixpkgs {
              system = "aarch64-linux";
              config.allowUnfree = true;
            };
            modules = [
              ../../hosts/oceando/configuration.nix
              inputs.home-manager.nixosModules.home-manager
              inputs.identities.nixosModules.oceando
              inputs.sops-nix.nixosModules.sops
              { home-manager.sharedModules = [ inputs.devlib.homeManagerModule ]; }
            ];
          };
        in
        oceando.config.system.build.streamLayeredImage;
    };
  };
}
