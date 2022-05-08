{ pkgs ? import <nixpkgs> { }, ... }:

{
  # Enable experimental features so we can access flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot = {
    # Increase the inotify limit for Syncthing
    kernel.sysctl."fs.inotify.max_user_watches" = "204800";
    # Emulate foreign executable via QEMU
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  # Virtualization settings
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    containerd.enable = true;
  };

  # Setup windowing environment
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "colemak";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Allows to manage devices via Gnome
  services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

  # Enable the OpenSSH daemon
  services.openssh.forwardX11 = true;

  # Manage fonts
  fonts = {
    fontDir.enable = true;
    fonts = [ pkgs.fira-code ];
  };

  # List packages installed in system profile To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.killall
    pkgs.git
    pkgs.xclip
    pkgs.inotify-tools
    pkgs.e2fsprogs
  ];

  # Define the network configurations
  networking = {
    hostName = "wonderland";
    enableIPv6 = true;
    # Priority to well known public DNS
    networkmanager.insertNameservers = [
      "1.1.1.2"
      "1.0.0.2"
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  # Enable the Bonjour protocol for local network discovery
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Enable the OpenSSH daemon
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable Network Time Protocol
  services.ntp.enable = true;

  # Keep the system timezone up-to-date based on the current location
  services.localtime.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  system.stateVersion = "21.11";
}
