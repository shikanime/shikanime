{
  nix.linux-builder.enable = true;

  homebrew.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
