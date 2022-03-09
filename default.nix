{ stdenv, lib, texlive }:

stdenv.mkDerivation {
  name = "shikanime-curriculum";
  buildInputs = [ texlive.combined.scheme-full ];
  src = lib.cleanSource ./curriculum;

  buildPhase = "pdflatex *.tex";
  installPhase = ''
    mkdir -p $out/share
    cp *.pdf $out/share
  '';
}
