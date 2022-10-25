{
  programs.ssh.matchBlocks = {
    "lvmh.ssh.dev.azure.com" = {
      hostname = "ssh.dev.azure.com";
      identityFile = "~/.ssh/lvmh_rsa";
    };
  };

  imports = [ ./sfeir.nix ];
}
