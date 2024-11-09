{ inputs, ... }:

{
  flake.darwinConfigurations.kaltashar = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      ../darwin/hosts/kaltashar.nix
      inputs.home-manager.darwinModules.home-manager
    ];
  };
}
