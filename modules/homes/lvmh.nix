{
  programs.ssh.matchBlocks = {
    "lvmh.ssh.dev.azure.com" = {
      hostname = "ssh.dev.azure.com";
      identityFile = "~/.ssh/lvmh_ed25519";
    };
  };

  imports = [ ./sfeir.nix ];
}
