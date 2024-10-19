{ self, inputs, withSystem, ... }:

{
  perSystem = _: {
    packages = {
      nishir-raspeberry-pi4-remilia-image =
        self.nixosConfigurations.nishir-raspeberry-pi4-remilia.config.system.build.sdImage;
      nishir-raspeberry-pi4-flandre-image =
        self.nixosConfigurations.nishir-raspeberry-pi4-flandre.config.system.build.sdImage;
    };
  };
  flake = {
    nixosConfigurations = {
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
