{ inputs, withSystem, ... }:

{
  flake = {
    packages.aarch64-linux.sd-image-raspberrypi-installer =
      withSystem "x86_64-linux" ({ pkgs, ... }:
        let
          installer = inputs.nixpkgs.lib.nixosSystem {
            inherit pkgs;
            modules = [
              ../nixos/installers/sd-image-raspberrypi-installer.nix
              inputs.home-manager.nixosModules.home-manager
            ];
          };
        in
        installer.config.system.build.sdImage);
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
      remilia = withSystem "aarch64-linux" ({ pkgs, ... }:
        inputs.nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ../nixos/hosts/remilia.nix
            inputs.disko.nixosModules.disko
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-facter-modules.nixosModules.facter
          ];
        });
      flandre = withSystem "aarch64-linux" ({ pkgs, ... }:
        inputs.nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ../nixos/hosts/flandre.nix
            inputs.disko.nixosModules.disko
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-facter-modules.nixosModules.facter
          ];
        });
    };
  };
}
