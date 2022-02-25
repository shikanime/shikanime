{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  name = "shikanime-curriculum";
  buildInputs = [ pkgs.texlive.combined.scheme-full ];
  src = pkgs.lib.cleanSource ./curriculum;

  buildPhase = "pdflatex *.tex";
  installPhase = ''
    mkdir -p $out/share
    cp *.pdf $out/share
  '';
}
