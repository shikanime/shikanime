{ stdenv
, terraform
, lib
}:

with lib;

stdenv.mkDerivation {
  name = "terraform-google-shikanime";
  buildInputs = [ terraform ];
  src = cleanSource ./.;
  installPhase = ''
    mkdir -p $out
    cp -r . $out
  '';
}
