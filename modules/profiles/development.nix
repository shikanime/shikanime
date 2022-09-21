{ pkgs, ... }:

{
  # Allow cgroup memory resize
  boot.kernelParams = [ "cgroup_enable=memory" "swapaccount=1" ];

  # Enable IPTable and debug module to be loaded
  security.lockKernelModules = true;

  # Optional packages
  environment.defaultPackages = [
    pkgs.gcc
    pkgs.binutils
    pkgs.inotify-tools
  ];

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

  # Manage fonts
  fonts = {
    fontDir.enable = true;
    fonts = [ pkgs.fira-code ];
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

  # Enable experimental features so we can access flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Add personal caching server
  nix.settings = {
    substituters = [
      "https://shikanime.cachix.org"
    ];
    trusted-public-keys = [
      "shikanime.cachix.org-1:OrpjVTH6RzYf2R97IqcTWdLRejF6+XbpFNNZJxKG8Ts="
    ];
  };

  # Allow unfree software such as Cloudflared or CUDA
  nixpkgs.config.allowUnfree = true;
}
