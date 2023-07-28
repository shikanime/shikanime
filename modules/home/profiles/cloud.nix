{ config, pkgs, lib, ... }:

with lib;

{
  home.packages = [
    pkgs.terraform
    pkgs.kustomize
    pkgs.skaffold
    pkgs.kind
    pkgs.minikube
    pkgs.azure-cli
    pkgs.awscli2
    pkgs.cloudflared
    pkgs.act
    pkgs.glab
    pkgs.kubelogin
    pkgs.kubelogin-oidc
    (pkgs.google-cloud-sdk.withExtraComponents (
      with pkgs.google-cloud-sdk.components; [
        alpha
        beta
        bq
        gsutil
        nomos
        gke-gcloud-auth-plugin
        gcloud-crc32c
      ]
    ))
  ];

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs.zsh.oh-my-zsh.plugins = [
    "kubectl"
    "helm"
    "minikube"
    "aws"
    "gcloud"
  ];

  programs.neovim.plugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      yaml
      dockerfile
      proto
      hcl
    ]))
  ];

  programs.zsh.initExtra = mkAfter ''
    if [ -d ${config.home.homeDirectory}/.rd ]; then
      export PATH=${config.home.homeDirectory}/.rd/bin:$PATH
    fi
  '';

  programs.git = {
    extraConfig = {
      credential."https://dev.azure.com".useHttpPath = true;
      credential."https://source.developers.google.com".helper =
        "${pkgs.google-cloud-sdk}/bin/git-credential-gcloud.sh";
    };
  };
}
