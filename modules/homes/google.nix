{ pkgs, config, ... }:

let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
    alpha
    beta
    bq
    gsutil
    nomos
    gke-gcloud-auth-plugin
    gcloud-crc32c
  ]);
in
{
  home.packages = [
    google-cloud-sdk
  ];

  # TODO: GCP auth plugin is deprecated in v1.22+, unavailable in v1.26+
  home.sessionVariables.USE_GKE_GCLOUD_AUTH_PLUGIN = "True";

  programs.zsh.oh-my-zsh.plugins = [
    "gcloud"
  ];
  programs.git.includes = [
    {
      condition = "gitdir:${config.home.homeDirectory}/";
      contents.extraConfig.credential."https://source.developers.google.com".helper =
        "${pkgs.google-cloud-sdk}/bin/git-credential-gcloud.sh";
    }
  ];
}
