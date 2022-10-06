{ pkgs, ... }:

{
  home.packages = [
    pkgs.kustomize
    pkgs.skaffold
    pkgs.kubectl
    pkgs.minikube
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "kubectl"
    "minikube"
  ];
}
