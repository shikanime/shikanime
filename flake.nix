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

    defaultPackage = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      with import nixpkgs { inherit system; };
      callPackage ./default.nix {
        nixosConfigurations = self.nixosConfigurations;
      }
    );

    devShell = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      import ./shell.nix {
        pkgs = import nixpkgs { inherit system; };
      }
    );

    nixosConfigurations = {
      oceando = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/machines/oceando.nix
          ./modules/profiles/devenv.nix
          ./modules/users/devas.nix
          home-manager.nixosModules.home-manager
        ];
      };
      elkia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/machines/elkia.nix
          ./modules/profiles/devenv.nix
          ./modules/users/devas.nix
          ./modules/remote/openssh.nix
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
          ./modules/machines/elvengard.nix
          ./modules/profiles/devenv.nix
          ./modules/users/devas.nix
          ./modules/remote/openssh.nix
          ./modules/remote/syncthing.nix
          ./modules/remote/time.nix
          ./modules/remote/jetbrains.nix
          ./modules/remote/vscode.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };

    homeConfigurations = {
      williamphetsinorath = home-manager.lib.homeManagerConfiguration rec {
        system = "x86_64-darwin";
        homeDirectory = "/Users/williamphetsinorath";
        username = "williamphetsinorath";
        stateVersion = "22.05";
        configuration = import ./home/default.nix {
          pkgs = import nixpkgs { inherit system; };
        };
      };
      devas = home-manager.lib.homeManagerConfiguration rec {
        system = "x86_64-linux";
        homeDirectory = "/home/devas";
        username = "devas";
        stateVersion = "22.05";
        configuration = import ./home/default.nix {
          pkgs = import nixpkgs { inherit system; };
        };
      };
      olva = home-manager.lib.homeManagerConfiguration rec {
        system = "x86_64-darwin";
        homeDirectory = "/Users/devas";
        username = "devas";
        stateVersion = "22.05";
        configuration = import ./home/default.nix {
          pkgs = import nixpkgs { inherit system; };
        };
      };
    };
  };
}
