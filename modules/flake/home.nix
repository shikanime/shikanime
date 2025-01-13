{ inputs, withSystem, ... }:

{
  flake.homeConfigurations.vscode = withSystem "x86_64-linux" (
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ../home/users/vscode.nix
        inputs.identities.homeManagerModules.vscode
      ];
    }
  );
}
