{
  # Create user accounts
  users.users.nixos = {
    isNormalUser = true;
    home = "/home/nixos";
    extraGroups = [ "wheel" ];
    initialHashedPassword = "";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGJ1GT3xsOpvFmXWOjNkCBjeRNn7tWiFV4bTXoYe3+V"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAB8e13bjswnhfuYYpztBESPf/gkbkdGE46kC++tNOCX"
    ];
  };

  # Configure user home
  home-manager.users.nixos = {
    imports = [
      ../../home/profiles/base.nix
    ];

    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableExtraSocket = true;
    };

    home.homeDirectory = "/home/nixos";
    home.username = "nixos";
  };
}
