{ pkgs, config, ... }:

{
  programs.ssh.matchBlocks = {
    "gcmd.birdz.com" = {
      hostname = "gcmd.birdz.com";
      identityFile = "~/.ssh/birdz_ed25519";
    };
  };

  imports = [ ./sfeir.nix ];
}
