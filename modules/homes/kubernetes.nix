{ pkgs, ... }:

{
  home.packages = [
    pkgs.minikube
    pkgs.kubectl
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "kubectl"
    "minikube"
  ];
}
