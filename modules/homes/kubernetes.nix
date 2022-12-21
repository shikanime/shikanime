{ pkgs, ... }:

{
  home.packages = [
    pkgs.kustomize
    pkgs.skaffold
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.minikube
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "kubectl"
    "helm"
    "minikube"
  ];
}
