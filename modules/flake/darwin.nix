{ inputs, withSystem, ... }:

{
  flake.darwinConfigurations = {
    kaltashar = withSystem "x86_64-darwin" (
      { system, ... }:
      inputs.nix-darwin.lib.darwinSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/kaltashar/darwin-configuration.nix
          inputs.home-manager.darwinModules.home-manager
          inputs.identities.darwinModules.kaltashar
          inputs.sops-nix.darwinModules.sops
        ];
      }
    );
    telsha = withSystem "aarch64-darwin" (
      { system, ... }:
      inputs.nix-darwin.lib.darwinSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/telsha/darwin-configuration.nix
          inputs.home-manager.darwinModules.home-manager
          inputs.identities.darwinModules.telsha
          inputs.sops-nix.darwinModules.sops
        ];
      }
    );
  };
}
