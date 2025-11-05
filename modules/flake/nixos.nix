{ inputs, withSystem, ... }:

{
  flake.nixosConfigurations = {
    oceando = withSystem "x86_64-linux" (
      { system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/oceando/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.identities.nixosModules.oceando
          inputs.sops-nix.nixosModules.sops
        ];
      }
    );
    fushi = withSystem "aarch64-linux" (
      { system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/fushi/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.identities.nixosModules.fushi
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          inputs.sops-nix.nixosModules.sops
        ];
      }
    );
    minish = withSystem "aarch64-linux" (
      { system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/minish/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.identities.nixosModules.minish
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          inputs.sops-nix.nixosModules.sops
        ];
      }
    );
    nishir = withSystem "aarch64-linux" (
      { system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/nishir/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.identities.nixosModules.nishir
          inputs.nixos-hardware.nixosModules.raspberry-pi-5
          inputs.sops-nix.nixosModules.sops
        ];
      }
    );
    nixtar = withSystem "x86_64-linux" (
      { system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/nixtar/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.identities.nixosModules.nixtar
          inputs.nixos-wsl.nixosModules.default
          inputs.sops-nix.nixosModules.sops
        ];
      }
    );
  };
}
