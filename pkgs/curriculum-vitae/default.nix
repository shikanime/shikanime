{ stdenv
, texlive
, lib
}:

with lib;

stdenv.mkDerivation {
  name = "curriculum-vitae";
  buildInputs = [ texlive.combined.scheme-full ];
  src = cleanSource ./.;
  installPhase = "cp *.pdf $out";
}
