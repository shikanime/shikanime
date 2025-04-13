{ inputs, withSystem, ... }:

{
  flake.packages.x86_64-linux.oceando = withSystem "x86_64-linux" (
    {
      self',
      pkgs,
      system,
      ...
    }:
    pkgs.callPackage ../../packages/oceando {
      nixosConfiguration = inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/oceando/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.identities.nixosModules.oceando
          inputs.sops-nix.nixosModules.sops
        ];
      };
    }
  );
}
