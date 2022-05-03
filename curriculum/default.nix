{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  name = "curriculum";
  buildInputs = [ pkgs.texlive.combined.scheme-full ];
  src = pkgs.lib.cleanSource ./.;

  buildPhase = "pdflatex *.tex";
  installPhase = ''
    mkdir -p $out/share
    cp *.pdf $out/share
  '';
}
