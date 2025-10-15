{
  config,
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

  programs.git.extraConfig.credential."https://gitlab.com".helper =
    "${pkgs.glab}/bin/glab auth git-credential";

  programs.helix.languages.language-server = {
    docker-compose-language-server.command = "${pkgs.docker-compose-language-service}/bin/docker-compose-langserver";
    dockerfile-langserver.command = "${pkgs.dockerfile-language-server-nodejs}/bin/dockerfile-language-server-nodejs";
  };

  programs.k9s.enable = true;

  programs.nushell.extraConfig = ''
    use ${pkgs.nu_scripts}/share/nu_scripts/modules/kubernetes *
  '';

  programs.ssh.matchBlocks."ssh.dev.azure.com".extraOptions = {
    HostkeyAlgorithms = "+ssh-rsa";
    PubkeyAcceptedKeyTypes = "+ssh-rsa";
  };
}
