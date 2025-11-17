{
  lib,
  pkgs,
  ...
}:

{
  programs = {
    docker-cli.enable = true;

    gh.enable = true;

    git.settings.credential."https://gitlab.com".helper = "${lib.getExe pkgs.glab} auth git-credential";

    helix.languages.language-server = {
      docker-compose-language-server.command = "${pkgs.docker-compose-language-service}/bin/docker-compose-langserver";
      dockerfile-langserver.command = "${pkgs.dockerfile-language-server}/bin/dockerfile-language-server";
    };

    k9s.enable = true;

    ssh.matchBlocks."ssh.dev.azure.com".extraOptions = {
      HostkeyAlgorithms = "+ssh-rsa";
      PubkeyAcceptedKeyTypes = "+ssh-rsa";
    };

    skaffold.enable = true;
  };
}
