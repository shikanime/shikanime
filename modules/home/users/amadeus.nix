{ config, pkgs, ... }:

{
  programs.git.includes = [
    {
      condition = "gitdir:${config.home.homeDirectory}/Amadeus/";
      contents.core.sshCommand = "${pkgs.openssh}/bin/ssh -i ${config.home.homeDirectory}/.ssh/amadeus_rsa";
    }
  ];
}
