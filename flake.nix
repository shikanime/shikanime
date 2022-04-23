{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      with import nixpkgs { inherit system; config.allowUnfree = true; }; {
        curriculum =
          import ./curriculum/default.nix { inherit stdenv lib texlive; };
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
