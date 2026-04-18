{
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${modulesPath}/profiles/headless.nix"
    ../../modules/nixos/base.nix
    ../../modules/nixos/workstation.nix
  ];

  home-manager.users = {
    automata.imports = [
      ./users/automata/home-configuration.nix
    ];
    shika.imports = [
      ./users/shika/home-configuration.nix
    ];
  };

  # Let Docker manage /etc/resolv.conf
  environment.etc."resolv.conf".enable = false;

  # Let Kubernetes manage the network configuration
  networking.useDHCP = false;

  programs.nix-ld = {
    enable = true;
    libraries = [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  systemd.tmpfiles.rules = [
    "Z /workspaces - root users - -"
  ];

  users.users = {
    shika = {
      extraGroups = [ "wheel" ];
      initialHashedPassword = "";
      isNormalUser = true;
      home = "/home/shika";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN6ORksXnayYquyZKEBQ8b0EEqwZRCeQFh1JlHZk9tQx"
      ];
    };

    automata = {
      initialHashedPassword = "";
      isNormalUser = true;
      home = "/home/automata";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOuenA6cT5pkPEwdGvmvXRjVqFTv2QwpyYrB7gvMy0/X"
      ];
    };
  };

  virtualisation.docker = {
    autoPrune.enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
