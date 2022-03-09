{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      with import nixpkgs { inherit system; }; {
        curriculum = import ./default.nix { inherit stdenv lib texlive; };
      });

    homeConfigurations = {
      altashar = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/williamphetsinorath";
        username = "williamphetsinorath";
        stateVersion = "21.11";
        configuration = { config, pkgs, ... }: {
          nixpkgs.config = import ./config.nix;
          imports = [ ./config/home.nix ./config/development.nix ];
        };
      };
      ishtar = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/devas";
        username = "devas";
        stateVersion = "21.11";
        configuration = { config, pkgs, ... }: {
          nixpkgs.config = import ./config.nix;
          imports = [
            ./config/home.nix
            ./config/development.nix
            ./config/linux/development.nix
          ];
        };
      };
      olva = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/devas";
        username = "devas";
        stateVersion = "21.11";
        configuration = { config, pkgs, ... }: {
          nixpkgs.config = import ./config.nix;
          imports = [ ./config/home.nix ./config/development.nix ];
        };
      };
    };
  };
}
