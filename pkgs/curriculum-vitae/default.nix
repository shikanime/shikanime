{ stdenv
, texlive
, lib
}:

with lib;

stdenv.mkDerivation {
  name = "curriculum-vitae";
  buildInputs = [ texlive.combined.scheme-full ];
  src = cleanSource ./.;
  buildPhase = "pdflatex *.tex";
  installPhase = "cp *.pdf $out";
}
