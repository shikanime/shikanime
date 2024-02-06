{
  # Configure Home Manager to use NixOS global packages
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # Desktop environment
  programs.hyprland.enable = true;

  # Deploy a nice default user friendly shell prompt
  programs.zsh.enable = true;

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

  # Cache SSH keys
  programs.ssh.startAgent = true;
}
