{ inputs, withSystem, ... }:

{
  flake.darwinConfigurations.kaltashar = withSystem "x86_64-darwin" (
    { system, ... }:
    inputs.nix-darwin.lib.darwinSystem {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      modules = [
        ../darwin/hosts/kaltashar.nix
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager.users.shikanimedeva.imports = [
            inputs.identities.homeModules.default
            inputs.identities.homeModules.richemont
          ];
        }
      ];
    }
  );
}
