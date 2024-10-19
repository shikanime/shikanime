{ config, pkgs, lib, ... }:

with lib;

{
  home.packages = [
    pkgs.glab
    pkgs.tea
  ];

  programs.gh = {
    enable = true;
    extensions = [ pkgs.gh-copilot ];
  };

  programs.zsh.oh-my-zsh.plugins = [
    "kubectl"
    "helm"
    "minikube"
    "aws"
    "gcloud"
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

  programs.git.extraConfig.credential."https://gitlab.com".helper =
    "${pkgs.glab}/bin/glab auth git-credential";
}
