{ pkgs ? import <nixpkgs> { } }:

pkgs.buildGoModule rec {
  pname = "metatube-sdk-go";
  version = "1.1.4";

  src = pkgs.fetchFromGitHub {
    owner = "metatube-community";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-guta0z/2/rNYBO/WmWQiH4kB1Nf49mHfgGAR/hcG9mc=";
  };

  vendorHash = "sha256-F9NZreIO74PrWG9nK3AZbyZlm7VIG2D0vTuXPhIKCWg=";

  ldflags = [
    "-X github.com/${src.owner}/${src.repo}/internal/version.Version=${version}"
    "-X github.com/${src.owner}/${src.repo}/internal/version.GitCommit=${src.rev}"
  ];

  doCheck = false;

  meta = with pkgs.lib; {
    description = "Scrape content from internet and response with JSON";
    homepage = "https://github.com//${src.owner}/${src.repo}";
    license = licenses.asl20;
    maintainers = with maintainers; [ shikanime ];
  };
}
