{ config, pkgs, lib, ... }:

with lib;

{
  home.packages = [
    pkgs.azure-cli
    pkgs.awscli2
    pkgs.aliyun-cli
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
        cloud-run-proxy
        log-streaming
        cloud_sql_proxy
      ]
    ))
  ];

  programs.gh.enable = true;

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

  programs.ssh.matchBlocks."ssh.dev.azure.com".extraOptions = {
    HostkeyAlgorithms = "+ssh-rsa";
    PubkeyAcceptedKeyTypes = "+ssh-rsa";
  };

  programs.git = {
    extraConfig.credential = {
      "https://github.com" = {
        useHttpPath = true;
        helper = "${pkgs.gh}/bin/gh auth git-credential";
      };
      "https://gitlab.com" = {
        useHttpPath = true;
        helper = "${pkgs.glab}/bin/glab auth git-credential";
      };
      "https://dev.azure.com".useHttpPath = true;
      "https://source.developers.google.com" = {
        useHttpPath = true;
        helper = "${pkgs.google-cloud-sdk}/bin/git-credential-gcloud.sh";
      };
    };
  };
}
