{ pkgs, ... }:

{
  home.packages = [
    pkgs.azure-cli
  ];

  programs.ssh.extraConfig = ''
    IdentitiesOnly yes
    HostKeyAlgorithms +ssh-rsa
    PubkeyAcceptedKeyTypes +ssh-rsa
  '';

  programs.git.extraConfig.credential."https://dev.azure.com".useHttpPath = true;
}
