{ stdenv
, texlive
, lib
}:

with lib;

stdenv.mkDerivation {
  name = "curriculum";
  buildInputs = [ texlive.combined.scheme-full ];
  src = cleanSource ./.;
  buildPhase = "pdflatex *.tex";
  installPhase = "cp *.pdf $out";
}
