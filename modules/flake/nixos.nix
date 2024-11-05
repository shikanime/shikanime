{ self, inputs, withSystem, ... }:

{
  perSystem = _: {
    packages = {
      ishtar-wsl-tarballBuilder =
        self.nixosConfigurations.ishtar-wsl.config.system.build.tarballBuilder;
      nishir-raspeberry-pi4-remilia-sdImage =
        self.nixosConfigurations.nishir-raspeberry-pi4-remilia.config.system.build.sdImage;
      nishir-raspeberry-pi4-flandre-sdImage =
        self.nixosConfigurations.nishir-raspeberry-pi4-flandre.config.system.build.sdImage;
    };
  };
  flake = {
    nixosConfigurations = {
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
      nishir-raspeberry-pi4-remilia = withSystem "aarch64-linux" ({ system, ... }:
        inputs.nixpkgs.lib.nixosSystem {
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [
            ../nixos/hosts/nishir-raspberry-pi-4-remilia.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-hardware.nixosModules.raspberry-pi-4
          ];
        });
      nishir-raspeberry-pi4-flandre = withSystem "aarch64-linux" ({ system, ... }:
        inputs.nixpkgs.lib.nixosSystem {
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [
            ../nixos/hosts/nishir-raspberry-pi-4-flandre.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-hardware.nixosModules.raspberry-pi-4
          ];
        });
    };
  };
}
