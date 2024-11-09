{ self, inputs, withSystem, ... }:

{
  flake = {
    packages.x86_64-linux.vscode-activationPackage =
      self.homeConfigurations.vscode.activationPackage;
    homeConfigurations.vscode = withSystem "x86_64-linux" ({ pkgs, ... }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ../home/users/vscode.nix
        ];
      });
  };
}
