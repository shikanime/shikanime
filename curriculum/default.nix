{ stdenv, lib, texlive }:

stdenv.mkDerivation {
  name = "curriculum";
  buildInputs = [ texlive.combined.scheme-full ];
  src = lib.cleanSource ./.;

  buildPhase = "pdflatex *.tex";
  installPhase = ''
    mkdir -p $out/share
    cp *.pdf $out/share
  '';
}
