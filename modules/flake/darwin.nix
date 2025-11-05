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
        inputs.identities.darwinModules.kaltashar
        inputs.sops-nix.darwinModules.sops
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
        inputs.identities.darwinModules.telsha
        inputs.sops-nix.darwinModules.sops
      ];
    };
  };
}
