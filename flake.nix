{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    devenv.url = "github:cachix/devenv";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
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
    inputs@{ self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , flake-parts
    , ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem = { pkgs, ... }: {
        treefmt = {
          projectRootFile = "flake.nix";
          enableDefaultExcludes = true;
          programs = {
            actionlint.enable = true;
            statix.enable = true;
            deadnix.enable = true;
            shfmt.enable = true;
            prettier.enable = true;
            nixpkgs-fmt.enable = true;
          };
        };
        devenv.shells.default = {
          containers = pkgs.lib.mkForce { };
          packages = [
            pkgs.gh
          ];
        };
      };
      flake = {
        packages = {
          x86_64-linux.elvengard-hyperv-image =
            self.nixosConfigurations.elvengard-hyperv.config.system.build.hypervImage;
          aarch64-linux.nishir-raspeberry-pi4-image =
            self.nixosConfigurations.nishir-raspeberry-pi4.config.system.build.sdImage;
        };
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
              ./modules/home/identities/shikanime.nix
            ];
          };
          "shika@ishtar" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
            modules = [
              ./modules/home/hosts/ishtar-shika.nix
              ./modules/home/identities/shikanime.nix
            ];
          };
          "willi@ishtar" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
            modules = [
              ./modules/home/hosts/ishtar-willi.nix
              ./modules/home/identities/shikanime.nix
            ];
          };
          "phetsinorathwilliam@baltashar" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              system = "aarch64-darwin";
              config.allowUnfree = true;
            };
            modules = [
              ./modules/home/hosts/baltashar-phetsinorathwilliam.nix
              ./modules/home/identities/shikanime.nix
            ];
          };
          "vscode@kaltashar" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
            modules = [
              ./modules/home/hosts/devcontainer-vscode.nix
              ./modules/home/identities/shikanime.nix
            ];
          };
          "vscode@ishtar" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
            modules = [
              ./modules/home/hosts/devcontainer-vscode.nix
              ./modules/home/identities/shikanime.nix
            ];
          };
          "vscode@baltashar" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              system = "aarch64-linux";
              config.allowUnfree = true;
            };
            modules = [
              ./modules/home/hosts/devcontainer-vscode.nix
              ./modules/home/identities/shikanime.nix
            ];
          };
        };
      };
    };
}
