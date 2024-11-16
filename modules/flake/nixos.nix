{ inputs, withSystem, ... }:

{
  flake.nixosConfigurations = {
    ishtar = withSystem "x86_64-linux" ({ system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../nixos/hosts/ishtar.nix
          inputs.determinate.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-wsl.nixosModules.default
        ];
      });
    remilia = withSystem "aarch64-linux" ({ system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../nixos/hosts/remilia.nix
          inputs.determinate.nixosModules.default
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
        ];
      });
    flandre = withSystem "aarch64-linux" ({ system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../nixos/hosts/flandre.nix
          inputs.determinate.nixosModules.default
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
        ];
      });
  };
}
