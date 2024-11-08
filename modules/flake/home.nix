{ self, inputs, withSystem, ... }:

{
  flake = {
    packages = {
      x86_64-linux = {
        shika-ishtar-activationPackage =
          self.homeConfigurations."shika@ishtar".activationPackage;
        willi-ishtar-activationPackage =
          self.homeConfigurations."willi@ishtar".activationPackage;
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
            ../home/hosts/shikanimedeva-kaltashar.nix
            ../home/identities/shikanime.nix
          ];
        });
      "shika@ishtar" = withSystem "x86_64-linux" ({ pkgs, ... }:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ../home/hosts/shika-ishtar.nix
            ../home/identities/shikanime.nix
          ];
        });
      "vscode@kaltashar" = withSystem "x86_64-linux" ({ pkgs, ... }:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ../home/hosts/vscode-devcontainer.nix
            ../home/identities/shikanime.nix
          ];
        });
      "vscode@ishtar" = withSystem "x86_64-linux" ({ pkgs, ... }:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ../home/hosts/vscode-devcontainer.nix
            ../home/identities/shikanime.nix
          ];
        });
    };
  };
}
