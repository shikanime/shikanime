{ pkgs, ... }:

{
  home.packages = [
    pkgs.google-cloud-sdk
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "gcloud"
  ];

  programs.git.extraConfig.credential."https://source.developers.google.com".helper =
    "${pkgs.google-cloud-sdk}/bin/git-credential-gcloud.sh";
}
