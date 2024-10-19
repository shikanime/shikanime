{ self, inputs, withSystem, ... }:

{
  perSystem = _: {
    packages = {
      elvengard-hyperv-image =
        self.nixosConfigurations.elvengard-hyperv.config.system.build.hypervImage;
      nishir-raspeberry-pi4-image =
        self.nixosConfigurations.nishir-raspeberry-pi4.config.system.build.sdImage;
    };
  };
  flake = {
    nixosConfigurations = {
      elvengard-hyperv = withSystem "x86_64-linux" ({ system, ... }:
        inputs.nixpkgs.lib.nixosSystem {
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [
            ../nixos/hosts/elvengard-hyperv.nix
            inputs.home-manager.nixosModules.home-manager
          ];
        });
      nishir-raspeberry-pi4 = withSystem "aarch64-linux" ({ system, ... }:
        inputs.nixpkgs.lib.nixosSystem {
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [
            ../nixos/hosts/nishir-raspberry-pi-4.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-hardware.nixosModules.raspberry-pi-4
          ];
        });
    };
  };
}
