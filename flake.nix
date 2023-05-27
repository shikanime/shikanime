{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-public-keys = [
      "shikanime.cachix.org-1:OrpjVTH6RzYf2R97IqcTWdLRejF6+XbpFNNZJxKG8Ts="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
    extra-substituters = [
      "https://shikanime.cachix.org"
      "https://devenv.cachix.org"
    ];
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , devenv
    , ...
    }@inputs:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
    in
    {
      packages = nixpkgs.lib.genAttrs systems (system:
        let pkgs = import nixpkgs { inherit system; }; in {
          curriculum-vitae = pkgs.callPackage ./pkgs/curriculum-vitae/default.nix { };
          elvengard = self.nixosConfigurations.elvengard.config.system.build.hypervImage;
          nishir = self.nixosConfigurations.nishir.config.system.build.sdImage;
        }
      );

      devShells = nixpkgs.lib.genAttrs systems (system:
        let pkgs = import nixpkgs { inherit system; }; in {
          default = devenv.lib.mkShell {
            inherit inputs pkgs;
            modules = [
              ./modules/devenv/base.nix
              ./modules/devenv/latex.nix
              ./modules/devenv/cloud.nix
            ];
          };
        }
      );

      nixosConfigurations = {
        elvengard = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/nixos/hosts/elvengard.nix
            home-manager.nixosModules.home-manager
          ];
        };
        nishir = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./modules/nixos/hosts/nishir.nix
            nixos-hardware.nixosModules.raspberry-pi-4
          ];
        };
      };

      homeConfigurations = {
        "williamphetsinorath@altashar" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/altashar.nix
          ];
        };
        "devas@ishtar" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/ishtar.nix
          ];
        };
        vscode = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/devcontainer.nix
          ];
        };
      };
    };
}
