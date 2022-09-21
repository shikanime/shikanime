{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.texlive.combined.scheme-full
    pkgs.rubocop
    pkgs.nixpkgs-fmt
  ];
}
