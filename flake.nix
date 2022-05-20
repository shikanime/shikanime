{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system: {
      curriculum = import ./curriculum/default.nix {
        pkgs = import nixpkgs { inherit system; };
      };
    });

    defaultPackage = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      import ./default.nix {
        pkgs = import nixpkgs { inherit system; };
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
          ./modules/oceando.nix
          ./modules/configuration.nix
          ./modules/home.nix
          home-manager.nixosModules.home-manager
        ];
      };
      elkia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/elkia.nix
          ./modules/configuration.nix
          ./modules/remote.nix
          ./modules/home.nix
          home-manager.nixosModules.home-manager
        ];
      };
      elvengard = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/elvengard.nix
          ./modules/configuration.nix
          ./modules/remote.nix
          ./modules/home.nix
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
        configuration = import ./home/default.nix {
          pkgs = import nixpkgs { system = "x86_64-darwin"; };
        };
      };
      devas = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/devas";
        username = "devas";
        stateVersion = "22.05";
        configuration = import ./home/default.nix {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        };
      };
      olva = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/devas";
        username = "devas";
        stateVersion = "22.05";
        configuration = import ./home/default.nix {
          pkgs = import nixpkgs { system = "x86_64-darwin"; };
        };
      };
    };
  };
}
