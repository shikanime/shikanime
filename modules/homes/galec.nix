{ pkgs, config, ... }:

{
  programs.ssh.matchBlocks = {
    "galec.ssh.dev.azure.com" = {
      hostname = "ssh.dev.azure.com";
      identityFile = "~/.ssh/galec_rsa";
    };
  };

  imports = [ ./sfeir.nix ];
}
