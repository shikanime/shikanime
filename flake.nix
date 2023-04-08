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

  outputs = { self, nixpkgs, nixos-hardware, home-manager, devenv, ... }@inputs:
    let
      supportedLinuxSystems = with nixpkgs.lib.platforms; nixpkgs.lib.lists.intersectLists x86_64 linux;
      supportedDarwinSystems = with nixpkgs.lib.platforms; nixpkgs.lib.lists.intersectLists x86_64 darwin;
      supportedSystems = supportedLinuxSystems ++ supportedDarwinSystems;
    in
    {
      packages = nixpkgs.lib.genAttrs supportedSystems (system:
        let pkgs = import nixpkgs { inherit system; }; in {
          curriculumVitae = pkgs.callPackage ./pkgs/curriculum-vitae/default.nix { };
          terraformGoogleShikanime = pkgs.callPackage ./pkgs/terraform-google-shikanime/default.nix { };
          elkia = self.nixosConfigurations.elkia.config.system.build.qcowImage;
          elvengard = self.nixosConfigurations.elvengard.config.system.build.hypervImage;
          nishir = self.nixosConfigurations.nishir.config.system.build.sdImage;
        }
      );

      devShells = nixpkgs.lib.genAttrs supportedSystems (system:
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
        elkia = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/hosts/elkia.nix
            ./modules/profiles/base.nix
            ./modules/profiles/development.nix
            ./modules/users/devas.nix
            ./modules/remote/ssh.nix
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
            ./modules/hosts/elvengard.nix
            ./modules/profiles/base.nix
            ./modules/profiles/development.nix
            ./modules/users/devas.nix
            ./modules/remote/ssh.nix
            ./modules/remote/syncthing.nix
            ./modules/remote/time.nix
            ./modules/remote/jetbrains.nix
            ./modules/remote/vscode.nix
            home-manager.nixosModules.home-manager
          ];
        };
        oceando = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/hosts/oceando.nix
            ./modules/profiles/base.nix
            ./modules/profiles/development.nix
            ./modules/users/devas.nix
            ./modules/remote/ssh.nix
            ./modules/remote/syncthing.nix
            ./modules/remote/time.nix
            ./modules/remote/jetbrains.nix
            ./modules/remote/vscode.nix
            home-manager.nixosModules.home-manager
          ];
        };
        nishir = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./modules/hosts/nishir.nix
            ./modules/profiles/base.nix
            ./modules/users/automata.nix
            ./modules/remote/ssh.nix
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
            ./modules/home/profiles/experimental/github-copilot-cli.nix
            ./modules/home/hosts/altashar.nix
            ./modules/home/users/google.nix
            ./modules/home/users/shikanime.nix
            ./modules/home/users/sfeir.nix
            ./modules/home/profiles/base.nix
            ./modules/home/profiles/vcs.nix
            ./modules/home/profiles/cc.nix
            ./modules/home/profiles/ruby.nix
            ./modules/home/profiles/beam.nix
            ./modules/home/profiles/go.nix
            ./modules/home/profiles/opam.nix
            ./modules/home/profiles/rust.nix
            ./modules/home/profiles/python.nix
            ./modules/home/profiles/web.nix
            ./modules/home/profiles/php.nix
            ./modules/home/profiles/latex.nix
            ./modules/home/profiles/sql.nix
            ./modules/home/profiles/cloud.nix
            ./modules/home/profiles/java.nix
            ./modules/home/profiles/dotnet.nix
          ];
        };
        "devas@ishtar" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/ishtar.nix
            ./modules/home/users/google.nix
            ./modules/home/users/shikanime.nix
            ./modules/home/users/sfeir.nix
            ./modules/home/profiles/wsl.nix
            ./modules/home/profiles/base.nix
            ./modules/home/profiles/xdg.nix
            ./modules/home/profiles/vcs.nix
            ./modules/home/profiles/cc.nix
            ./modules/home/profiles/ruby.nix
            ./modules/home/profiles/beam.nix
            ./modules/home/profiles/go.nix
            ./modules/home/profiles/opam.nix
            ./modules/home/profiles/rust.nix
            ./modules/home/profiles/python.nix
            ./modules/home/profiles/web.nix
            ./modules/home/profiles/php.nix
            ./modules/home/profiles/latex.nix
            ./modules/home/profiles/sql.nix
            ./modules/home/profiles/cloud.nix
            ./modules/home/profiles/java.nix
            ./modules/home/profiles/dotnet.nix
          ];
        };
        vscode = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./modules/home/hosts/vscode.nix
            ./modules/home/profiles/devcontainer.nix
            ./modules/home/profiles/base.nix
            ./modules/home/profiles/xdg.nix
          ];
        };
      };
    };
}
