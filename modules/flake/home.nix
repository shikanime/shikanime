{ self, inputs, withSystem, ... }:

{
  flake = {
    packages = {
      x86_64-linux = {
        vscode-kaltashar-activationPackage =
          self.homeConfigurations."vscode@kaltashar".activationPackage;
        vscode-ishtar-activationPackage =
          self.homeConfigurations."vscode@ishtar".activationPackage;
      };
      x86_64-darwin.shikanimedeva-kaltashar-activationPackage =
        self.homeConfigurations."shikanimedeva@kaltashar".activationPackage;
    };
    homeConfigurations = {
      "shikanimedeva@kaltashar" = withSystem "x86_64-darwin" ({ pkgs, ... }:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ../home/users/shikanimedeva-kaltashar.nix
          ];
        });
      "vscode" = withSystem "x86_64-linux" ({ pkgs, ... }:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ../home/users/vscode.nix
          ];
        });
    };
  };
}
