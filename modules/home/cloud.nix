{ pkgs, ... }:

{
  programs = {
    docker-cli.enable = true;

    gh.enable = true;

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

  xdg.configFile."containers/policy.json".source =
    let
      format = pkgs.formats.json { };
    in
    format.generate "policy.json" {
      default = [
        { type = "insecureAcceptAnything"; }
      ];
      transports.docker-daemon = {
        "" = [ { type = "insecureAcceptAnything"; } ];
      };
    };
}
