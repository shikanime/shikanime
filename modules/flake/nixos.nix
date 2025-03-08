{ inputs, withSystem, ... }:

{
  flake.nixosConfigurations = {
    devcontainer = withSystem "x86_64-linux" (
      { system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../nixos/hosts/devcontainer.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.identities.nixosModules.devcontainer
          inputs.sops-nix.nixosModules.sops
        ];
      }
    );
    flandre = withSystem "aarch64-linux" (
      { system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../nixos/hosts/fushi.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          inputs.sops-nix.nixosModules.sops
        ];
      }
    );
    ishtar = withSystem "x86_64-linux" (
      { system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../nixos/hosts/ishtar.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.identities.nixosModules.ishtar
          inputs.nixos-wsl.nixosModules.default
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
          ../nixos/hosts/nishir.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          inputs.sops-nix.nixosModules.sops
        ];
      }
    );
  };
}
