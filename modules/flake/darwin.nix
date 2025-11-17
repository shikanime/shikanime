{ inputs, ... }:

{
  flake.darwinConfigurations = {
    kaltashar = inputs.nix-darwin.lib.darwinSystem {
      pkgs = import inputs.nixpkgs {
        system = "x86_64-darwin";
        config.allowUnfree = true;
      };
      modules = [
        ../../hosts/kaltashar/darwin-configuration.nix
        inputs.home-manager.darwinModules.home-manager
        inputs.sops-nix.darwinModules.sops
        {
          home-manager.sharedModules = [
            inputs.devlib.homeManagerModule
            inputs.sops-nix.homeManagerModule
          ];
        }
      ];
    };
    telsha = inputs.nix-darwin.lib.darwinSystem {
      pkgs = import inputs.nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      modules = [
        ../../hosts/telsha/darwin-configuration.nix
        inputs.home-manager.darwinModules.home-manager
        inputs.sops-nix.darwinModules.sops
        {
          home-manager.sharedModules = [
            inputs.devlib.homeManagerModule
            inputs.sops-nix.homeManagerModule
          ];
        }
      ];
    };
  };
}
