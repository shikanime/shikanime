{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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
      formatter = nixpkgs.lib.genAttrs systems (system:
        let pkgs = import nixpkgs { inherit system; }; in
        pkgs.nixpkgs-fmt
      );

      packages = nixpkgs.lib.genAttrs systems (system:
        let pkgs = import nixpkgs { inherit system; }; in {
          nishir = self.nixosConfigurations.nishir.config.system.build.sdImage;
          altashar = self.homeConfigurations."williamphetsinorath@altashar".activationPackage;
          ishtar = self.homeConfigurations."shika@ishtar".activationPackage;
          devcontainer = self.homeConfigurations.vscode.activationPackage;
          metatube = pkgs.callPackage ./pkgs/metatube { };
        }
      );

      devShells = nixpkgs.lib.genAttrs systems (system:
        let pkgs = import nixpkgs { inherit system; }; in {
          default = devenv.lib.mkShell {
            inherit inputs pkgs;
            modules = [
              ./modules/devenv/base.nix
              ./modules/devenv/vcs.nix
            ];
          };
        }
      );

      nixosConfigurations.nishir = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./modules/nixos/hosts/nishir.nix
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.raspberry-pi-4
        ];
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
        "shika@ishtar" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/ishtar.nix
          ];
        };
        "shika@nishir" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/nishir.nix
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
