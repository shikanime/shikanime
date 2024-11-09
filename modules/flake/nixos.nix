{ self, inputs, withSystem, ... }:

{
  perSystem = _: {
    packages = {
      ishtar-tarballBuilder =
        self.nixosConfigurations.ishtar.config.system.build.tarballBuilder;
      remilia-sdImage =
        self.nixosConfigurations.remilia.config.system.build.sdImage;
      flandre-sdImage =
        self.nixosConfigurations.flandre.config.system.build.sdImage;
    };
  };
  flake.nixosConfigurations = {
    ishtar = withSystem "x86_64-linux" ({ system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../nixos/hosts/ishtar.nix
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
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
        ];
      });
  };
}
