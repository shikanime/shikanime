{ pkgs, ... }:

{
  home.packages = [
    pkgs.docker-compose-language-service
    pkgs.dockerfile-language-server
    pkgs.yaml-language-server
  ];

  programs = {
    docker-cli.enable = true;

    gh.enable = true;

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
