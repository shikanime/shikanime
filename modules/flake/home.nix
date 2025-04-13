{ inputs, withSystem, ... }:

{
  flake.homeConfigurations.vscode = withSystem "x86_64-linux" (
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ../../hosts/devcontainer/home-configuration.nix
        inputs.identities.homeManagerModules.vscode
        inputs.sops-nix.homeManagerModules.sops
      ];
    }
  );
}
