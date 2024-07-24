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
    }@inputs: {
      formatter = nixpkgs.lib.genAttrs [ "x86_64-linux" "x86_64-darwin" ] (system:
        let pkgs = import nixpkgs { inherit system; }; in
        pkgs.nixpkgs-fmt
      );

      packages = nixpkgs.lib.mergeAttrsList [
        (nixpkgs.lib.genAttrs [ "x86_64-linux" "x86_64-darwin" ] (system:
          let pkgs = import nixpkgs { inherit system; }; in {
            elvengard-hyperv-image =
              self.nixosConfigurations.elvengard-hyperv.config.system.build.hypervImage;
          }
        ))
        (nixpkgs.lib.genAttrs [ "aarch64-linux" ] (system:
          let pkgs = import nixpkgs { inherit system; }; in {
            nishir-raspeberry-pi4-image =
              self.nixosConfigurations.nishir-raspeberry-pi4.config.system.build.sdImage;
          }
        ))
      ];

      devShells = nixpkgs.lib.genAttrs [ "x86_64-linux" "x86_64-darwin" ] (system:
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

      nixosConfigurations = {
        elvengard-hyperv = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/nixos/hosts/elvengard-hyperv.nix
            home-manager.nixosModules.home-manager
          ];
        };
        nishir-raspeberry-pi4 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./modules/nixos/hosts/nishir-raspberry-pi-4.nix
            home-manager.nixosModules.home-manager
            nixos-hardware.nixosModules.raspberry-pi-4
          ];
        };
      };

      homeConfigurations = {
        "shikanimedeva@kaltashar" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/kaltashar-shikanimedeva.nix
          ];
        };
        "williamphetsinorath@altashar" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/altashar-williamphetsinorath.nix
          ];
        };
        "shika@ishtar" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/ishtar-shika.nix
          ];
        };
        "willi@ishtar" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/ishtar-willi.nix
          ];
        };
        "shika@nishir" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/nishir-shika.nix
          ];
        };
        vscode = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/vscode.nix
          ];
        };
      };
    };
}
