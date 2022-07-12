{ mkShell
, texlive
, rubocop
, nixpkgs-fmt
}:

mkShell {
  buildInputs = [
    texlive.combined.scheme-full
    rubocop
    nixpkgs-fmt
  ];
}
