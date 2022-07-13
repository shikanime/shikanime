{ pkgs ? import <nixpkgs> { }, ... }:

{
  # Global system specific packages
  environment.systemPackages = [
    pkgs.inotify-tools
  ];

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
