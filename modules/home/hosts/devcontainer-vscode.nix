{ pkgs, ... }:

{
  imports = [
    ./devcontainer-base.nix
  ];

  home = {
    homeDirectory = "/home/vscode";
    username = "vscode";
  };

  home.packages = [
    pkgs.texlive.combined.scheme-full
    (pkgs.google-cloud-sdk.withExtraComponents (
      with pkgs.google-cloud-sdk.components; [
        alpha
        beta
        bq
        gsutil
        gke-gcloud-auth-plugin
        gcloud-crc32c
      ]
    ))
  ];

  programs.k9s.enable = true;
}
