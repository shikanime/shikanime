{ pkgs ? import <nixpkgs> { }, ... }:

{
  # Create user accounts
  users.users.devas = {
    isNormalUser = true;
    home = "/home/devas";
    extraGroups = [ "docker" "wheel" "kvm" "vboxsf" ];
    shell = pkgs.zsh;
    hashedPassword = "$6$YS5jCyZU2Z6i05wm$jFsx9fnINawEk2Vd5uZBdR71sOBHHgANUEBsp93fG3scp2uui3kYhzXh9c4eC4ZdHKq48//IWE00JwZ.ez.lg.";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7pi5OYqzuMkTymIbJUJteIU3dz+OgduiF5O9cA+B7u devas@ishtar"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFChPMDHee+8F8tuchk8nLqdzVj1SOfLFv70NH95K6Yf williamphetsinorath@altashar"
    ];
  };

  # Enable experimental features so we can access flakes.
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';


  # We expect to run the VM on hidpi machines.
  hardware.video.hidpi.enable = true;

  boot = {
    # Allow installation process to modify EFI boot variables.
    loader.efi.canTouchEfiVariables = true;
    # KVM kernel modules.
    kernelModules = [ "kvm-intel" "kvm-amd" ];
    # Increase the inotify limit.
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = "204800";
    };
  };

  # Define the network configurations.
  networking = {
    hostName = "wonderland";
    enableIPv6 = true;
    # Priority to well known public DNS.
    networkmanager.insertNameservers = [
      "1.1.1.2"
      "1.0.0.2"
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  # Virtualization settings
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    containerd.enable = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Manage fonts.
  fonts = {
    fontDir.enable = true;
    fonts = [ pkgs.fira-code ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.killall
    pkgs.git
    pkgs.xclip
    pkgs.inotify-tools
    pkgs.e2fsprogs
    pkgs.xorg.xrandr
  ];

  # Enable the Bonjour protocol for local network discovery.
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Setup windowing environment.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Allows to manage devices via Gnome.
  services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    forwardX11 = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  # Enable Network Time Protocol
  services.ntp.enable = true;

  # Keep the system timezone up-to-date based on the current location.
  services.localtime.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11";
}
