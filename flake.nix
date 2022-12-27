{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    packages = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      with import nixpkgs { inherit system; }; {
        curriculumVitae = callPackage ./pkgs/curriculum-vitae/default.nix { };
      }
    );

    devShell = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      with import nixpkgs { inherit system; };
      pkgs.mkShell {
        buildInputs = [
          pkgs.texlive.combined.scheme-full
          pkgs.rubocop
          pkgs.nixpkgs-fmt
        ];
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
          ./modules/homes/host.nix
          ./modules/homes/altashar.nix
          ./modules/homes/base.nix
          ./modules/homes/totalenergies.nix
          ./modules/homes/version-control.nix
          ./modules/homes/cpp.nix
          ./modules/homes/ruby.nix
          ./modules/homes/bazel.nix
          ./modules/homes/beam.nix
          ./modules/homes/go.nix
          ./modules/homes/opam.nix
          ./modules/homes/rustup.nix
          ./modules/homes/python.nix
          ./modules/homes/web.nix
          ./modules/homes/php.nix
          ./modules/homes/latex.nix
          ./modules/homes/sql.nix
          ./modules/homes/cloud.nix
          ./modules/homes/shikanime.nix
          ./modules/homes/sfeir.nix
          ./modules/homes/galec.nix
          ./modules/homes/lvmh.nix
          ./modules/homes/birdz.nix
          ./modules/homes/java.nix
          ./modules/homes/dotnet.nix
        ];
      };
      "devas@ishtar" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = [
          ./modules/homes/host.nix
          ./modules/homes/ishtar.nix
          ./modules/homes/base.nix
          ./modules/homes/totalenergies.nix
          ./modules/homes/version-control.nix
          ./modules/homes/cpp.nix
          ./modules/homes/cuda.nix
          ./modules/homes/ruby.nix
          ./modules/homes/bazel.nix
          ./modules/homes/beam.nix
          ./modules/homes/go.nix
          ./modules/homes/opam.nix
          ./modules/homes/rustup.nix
          ./modules/homes/python.nix
          ./modules/homes/web.nix
          ./modules/homes/php.nix
          ./modules/homes/latex.nix
          ./modules/homes/sql.nix
          ./modules/homes/cloud.nix
          ./modules/homes/shikanime.nix
          ./modules/homes/sfeir.nix
          ./modules/homes/galec.nix
          ./modules/homes/lvmh.nix
          ./modules/homes/birdz.nix
          ./modules/homes/java.nix
          ./modules/homes/dotnet.nix
          ./modules/homes/xdg.nix
        ];
      };
    };
  };
}
