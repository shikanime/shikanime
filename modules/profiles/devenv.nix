{ pkgs ? import <nixpkgs> { }, ... }:

{
  # Virtualization settings
  virtualisation = {
    docker.enable = true;
    containerd.enable = true;
  };

  # Cache SSH keys
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };

  # Cache GnuPG keys
  programs.gnupg.agent = {
    enable = true;
    enableExtraSocket = true;
    pinentryFlavor = "tty";
  };
}
