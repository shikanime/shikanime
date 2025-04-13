{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

{
  home.packages = [
    pkgs.glab
    pkgs.k9s
    pkgs.tea
  ];

  programs.fish.interactiveShellInit = mkAfter ''
    if test -d "${config.home.homeDirectory}/.rd"
      set -gx PATH "${config.home.homeDirectory}/.rd/bin" $PATH
    end
  '';

  programs.gh.enable = true;

  programs.git.extraConfig.credential."https://gitlab.com".helper =
    "${pkgs.glab}/bin/glab auth git-credential";

  programs.helix.languages.language-server = {
    docker-compose-language-server.command = "${pkgs.docker-compose-language-service}/bin/docker-compose-langserver";
    dockerfile-langserver.command = "${pkgs.dockerfile-language-server-nodejs}/bin/dockerfile-language-server-nodejs";
  };

  programs.nushell.extraConfig = ''
    use ${pkgs.nu_scripts}/share/nu_scripts/modules/kubernetes *
  '';

  programs.ssh.matchBlocks."ssh.dev.azure.com".extraOptions = {
    HostkeyAlgorithms = "+ssh-rsa";
    PubkeyAcceptedKeyTypes = "+ssh-rsa";
  };
}
