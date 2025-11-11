{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.glab
    pkgs.tea
  ];

  programs.docker-cli.enable = true;

  programs.gh.enable = true;

  programs.git.settings.credential."https://gitlab.com".helper =
    "${lib.getExe glab} auth git-credential";

  programs.helix.languages.language-server = {
    docker-compose-language-server.command = "${pkgs.docker-compose-language-service}/bin/docker-compose-langserver";
    dockerfile-langserver.command = "${pkgs.dockerfile-language-server}/bin/dockerfile-language-server";
  };

  programs.k9s.enable = true;

  programs.ssh.matchBlocks."ssh.dev.azure.com".extraOptions = {
    HostkeyAlgorithms = "+ssh-rsa";
    PubkeyAcceptedKeyTypes = "+ssh-rsa";
  };

  programs.skaffold.enable = true;
}
