{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  configDir =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "Library/Application Support"
    else
      removePrefix config.home.homeDirectory config.xdg.configHome;
in
{
  home.file."${configDir}/containers/policy.json".source =
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

  programs = {
    k9s.enable = true;

    ssh.matchBlocks."ssh.dev.azure.com".extraOptions = {
      HostkeyAlgorithms = "+ssh-rsa";
      PubkeyAcceptedKeyTypes = "+ssh-rsa";
    };
  };
}
