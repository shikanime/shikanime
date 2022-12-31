{ pkgs, config, ... }:

{
  home.packages = [
    pkgs.kustomize
    pkgs.skaffold
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.minikube
    pkgs.azure-cli
    pkgs.awscli2
    pkgs.cloudflared
    pkgs.github-cli
    pkgs.terraform
    pkgs.python310Packages.huggingface-hub
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

  programs.zsh.initExtra = ''
    if [ -d ${config.home.homeDirectory}/.rd ]; then
      export PATH=${config.home.homeDirectory}/.rd/bin:$PATH
    fi
  '';

  programs.ssh.matchBlocks = {
    "ssh.dev.azure.com" = {
      extraOptions = {
        HostkeyAlgorithms = "+ssh-rsa";
        PubkeyAcceptedAlgorithms = "+ssh-rsa";
      };
    };
  };

  programs.git = {
    extraConfig.credential."https://dev.azure.com".useHttpPath = true;
    includes = [
      {
        condition = "gitdir:${config.home.homeDirectory}/";
        contents.extraConfig.credential."https://source.developers.google.com".helper =
          "${pkgs.google-cloud-sdk}/bin/git-credential-gcloud.sh";
      }
    ];
  };
}
