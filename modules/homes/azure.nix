{ pkgs, ... }:

{
  home.packages = [
    pkgs.azure-cli
  ];

  programs.ssh.matchBlocks = {
    "ssh.dev.azure.com" = {
      extraOptions = {
        HostkeyAlgorithms = "+ssh-rsa";
        PubkeyAcceptedAlgorithms = "+ssh-rsa";
      };
    };
  };
  programs.git.extraConfig.credential."https://dev.azure.com".useHttpPath = true;
}

