{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv";
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

  outputs = { nixpkgs, home-manager, devenv, ... } @ inputs: {
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      let pkgs = import nixpkgs { inherit system; }; in {
        curriculumVitae = pkgs.callPackage ./pkgs/curriculum-vitae/default.nix { };
      }
    );

    devShells = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      let pkgs = import nixpkgs { inherit system; }; in {
        default = devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [
            ./modules/devenv/base.nix
            ./modules/devenv/latex.nix
            ./modules/devenv/nix.nix
          ];
        };
      }
    );

    nixosConfigurations = {
      elkia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/profiles/qcow-image.nix
          ./modules/profiles/base.nix
          ./modules/profiles/development.nix
          ./modules/profiles/home.nix
          ./modules/profiles/elkia.nix
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
          ./modules/virtualisation/hyperv.nix
          ./modules/profiles/base.nix
          ./modules/profiles/development.nix
          ./modules/profiles/home.nix
          ./modules/profiles/elvengard.nix
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
          ./modules/profiles/base.nix
          ./modules/profiles/development.nix
          ./modules/profiles/home.nix
          ./modules/profiles/oceando.nix
          ./modules/users/devas.nix
          ./modules/remote/ssh.nix
          ./modules/remote/syncthing.nix
          ./modules/remote/time.nix
          ./modules/remote/jetbrains.nix
          ./modules/remote/vscode.nix
          home-manager.nixosModules.home-manager
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
          ./modules/home/host.nix
          ./modules/home/altashar.nix
          ./modules/home/base.nix
          ./modules/home/vcs.nix
          ./modules/home/cc.nix
          ./modules/home/ruby.nix
          ./modules/home/beam.nix
          ./modules/home/go.nix
          ./modules/home/opam.nix
          ./modules/home/rust.nix
          ./modules/home/python.nix
          ./modules/home/web.nix
          ./modules/home/php.nix
          ./modules/home/latex.nix
          ./modules/home/sql.nix
          ./modules/home/cloud.nix
          ./modules/home/shikanime.nix
          ./modules/home/sfeir.nix
          ./modules/home/java.nix
          ./modules/home/dotnet.nix
        ];
      };
      "devas@ishtar" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = [
          ./modules/home/wsl.nix
          ./modules/home/host.nix
          ./modules/home/ishtar.nix
          ./modules/home/base.nix
          ./modules/home/vcs.nix
          ./modules/home/cc.nix
          ./modules/home/ruby.nix
          ./modules/home/beam.nix
          ./modules/home/go.nix
          ./modules/home/opam.nix
          ./modules/home/rust.nix
          ./modules/home/python.nix
          ./modules/home/web.nix
          ./modules/home/php.nix
          ./modules/home/latex.nix
          ./modules/home/sql.nix
          ./modules/home/cloud.nix
          ./modules/home/shikanime.nix
          ./modules/home/sfeir.nix
          ./modules/home/java.nix
          ./modules/home/dotnet.nix
          ./modules/home/xdg.nix
        ];
      };
      vscode = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./modules/home/devcontainer.nix
          ./modules/home/base.nix
          ./modules/home/xdg.nix
        ];
      };
    };
  };
}
