{ stdenv
, texlive
, lib
}:

stdenv.mkDerivation {
  name = "curriculum";
  buildInputs = [ texlive.combined.scheme-full ];
  src = lib.cleanSource ./.;

  buildPhase = "pdflatex *.tex";
  installPhase = ''
    cp *.pdf $out
  '';
}
