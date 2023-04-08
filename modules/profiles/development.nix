{
  # Allow cgroup memory resize
  boot.kernelParams = [ "cgroup_enable=memory" "swapaccount=1" ];

  # Enable IPTable and debug module to be loaded
  security.lockKernelModules = true;

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  virtualisation = {
    containerd.enable = true;
    containers.enable = true;
  };

  # Deploy a nice default user friendly shell prompt
  programs.zsh.enable = true;

  # Cache SSH keys
  programs.ssh.startAgent = true;

  # Cache GnuPG keys
  programs.gnupg.agent = {
    enable = true;
    enableExtraSocket = true;
    pinentryFlavor = "tty";
  };
}
