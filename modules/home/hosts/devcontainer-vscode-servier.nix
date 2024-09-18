{ pkgs, ... }:

{
  imports = [
    ./devcontainer-vscode.nix
  ];

  home.packages = [
    pkgs.pipx
    pkgs.nodejs_22
    pkgs.terraform
    pkgs.argocd
    pkgs.maven
    pkgs.spark
    (pkgs.google-cloud-sdk.withExtraComponents (
      with pkgs.google-cloud-sdk.components; [
        alpha
        beta
        bq
        gsutil
        gke-gcloud-auth-plugin
        gcloud-crc32c
        kubectl
        kustomize
      ]
    ))
  ];

  programs.java.enable = true;

  programs.k9s.enable = true;
}
