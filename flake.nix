{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-generators }: {
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      let pkgs = import nixpkgs { inherit system; }; in
      {
        curriculum = import ./curriculum/default.nix {
          inherit pkgs;
        };
      }
    );

    defaultPackage = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      let pkgs = import nixpkgs { inherit system; }; in
      import ./default.nix {
        inherit pkgs;
        nixosConfigurations = self.nixosConfigurations;
      }
    );

    devShells = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      let pkgs = import nixpkgs { inherit system; }; in
      {
        curriculum = import ./curriculum/shell.nix {
          inherit pkgs;
        };
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
      altashar = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/williamphetsinorath";
        username = "williamphetsinorath";
        stateVersion = "21.11";
        configuration = { config, pkgs, ... }: {
          imports = [ ./home/default.nix ];
        };
      };
      ishtar = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/devas";
        username = "devas";
        stateVersion = "21.11";
        configuration = { config, pkgs, ... }: {
          imports = [ ./home/default.nix ];
        };
      };
      olva = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/devas";
        username = "devas";
        stateVersion = "21.11";
        configuration = { config, pkgs, ... }: {
          imports = [ ./home/default.nix ];
        };
      };
    };
  };
}
