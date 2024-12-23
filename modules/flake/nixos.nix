{ inputs, withSystem, ... }:

{
  flake.nixosConfigurations = {
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
          inputs.nixos-wsl.nixosModules.default
          {
            home-manager.users.shika.imports = [
              inputs.identities.homeModules.default
              inputs.identities.homeModules.richemont
            ];
          }
        ];
      }
    );
    remilia = withSystem "aarch64-linux" (
      { system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../nixos/hosts/remilia.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
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
          ../nixos/hosts/flandre.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
        ];
      }
    );
  };
}
