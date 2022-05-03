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
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system: {
      curriculum = import ./curriculum/default.nix {
        pkgs = import nixpkgs { inherit system; };
      };

      wonderland = nixpkgs.lib.genAttrs [ "virtualbox" "hyperv" ]
        (format: nixos-generators.nixosGenerate {
          inherit format;
          pkgs = import nixpkgs { inherit system; };
          modules = [
            ./nixos/modules/configuration.nix
            ./nixos/modules/home-manager.nix
            home-manager.nixosModules.home-manager
          ];
        });
    });

    homeConfigurations = {
      altashar = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/williamphetsinorath";
        username = "williamphetsinorath";
        stateVersion = "21.11";
        configuration = { config, pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;
          imports = [ ./nixpkgs/home.nix ];
        };
      };
      ishtar = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/devas";
        username = "devas";
        stateVersion = "21.11";
        configuration = { config, pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;
          imports = [ ./nixpkgs/home.nix ];
        };
      };
      olva = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/devas";
        username = "devas";
        stateVersion = "21.11";
        configuration = { config, pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;
          imports = [ ./nixpkgs/home.nix ];
        };
      };
    };
  };
}
