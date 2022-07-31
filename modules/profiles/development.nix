{ pkgs, ... }:

{
  # Global system specific packages
  environment.systemPackages = [
    pkgs.inotify-tools
  ];

  # Configure Java home globally for tools that do not
  # rely on the shell dotfiles
  programs.java.enable = true;

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
