{ inputs, withSystem, ... }:

{
  perSystem = { pkgs, ... }: {
    packages.sd-image-raspberrypi-installer =
      let
        nixosConfiguration = inputs.nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ../nixos/installers/sd-image-raspberrypi-installer.nix
          ];
        };
      in
      nixosConfiguration.config.system.build.sdImage;
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
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-facter-modules.nixosModules.facter
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
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-facter-modules.nixosModules.facter
        ];
      });
  };
}
