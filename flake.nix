{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      with import nixpkgs { inherit system; }; {
        curriculum = callPackage ./pkgs/curriculum/default.nix { };
      });

    devShell = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      with import nixpkgs { inherit system; };
      callPackage ./shell.nix { }
    );

    nixosConfigurations = {
      elkia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/virtualisation/utm.nix
          ./modules/profiles/base.nix
          ./modules/profiles/development.nix
          ./modules/profiles/elkia.nix
          ./modules/users/devas.nix
          ./modules/remote/ssh.nix
          ./modules/remote/syncthing.nix
          ./modules/remote/time.nix
          ./modules/remote/jetbrains.nix
          ./modules/remote/vscode.nix
          home-manager.nixosModules.home-manager
        ];
      };
      elvengard = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/virtualisation/hyperv.nix
          ./modules/profiles/base.nix
          ./modules/profiles/development.nix
          ./modules/profiles/elvengard.nix
          ./modules/users/devas.nix
          ./modules/remote/ssh.nix
          ./modules/remote/syncthing.nix
          ./modules/remote/time.nix
          ./modules/remote/jetbrains.nix
          ./modules/remote/vscode.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };

    homeConfigurations = {
      williamphetsinorath = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/williamphetsinorath";
        username = "williamphetsinorath";
        stateVersion = "22.05";
        configuration = ./modules/homes/host.nix;
        extraModules = [
          ./modules/homes/base.nix
        ];
      };
      devas = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/devas";
        username = "devas";
        stateVersion = "22.05";
        configuration = ./modules/homes/host.nix;
        extraModules = [
          ./modules/homes/base.nix
        ];
      };
      olva = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/devas";
        username = "devas";
        stateVersion = "22.05";
        configuration = ./modules/homes/host.nix;
        extraModules = [
          ./modules/homes/base.nix
        ];
      };
    };
  };
}
