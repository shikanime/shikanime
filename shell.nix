{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nixpkgs-fmt
    pkgs.texlive.combined.scheme-full
  ];
}
