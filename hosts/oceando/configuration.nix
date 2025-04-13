{
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/virtualisation/docker-image.nix"
    ../../modules/nixos/base.nix
    ../../modules/nixos/workstation.nix
  ];

  environment.systemPackages = [
    pkgs.coreutils
    pkgs.git
    pkgs.gnugrep
    pkgs.gnused
    pkgs.gnutar
    pkgs.gzip
  ];

  home-manager.users.vscode.imports = [
    ./users/vscode/home-configuration.nix
  ];

  users.users.vscode = {
    initialHashedPassword = "";
    isNormalUser = true;
    extraGroups = [
      "docker"
      "wheel"
    ];
    home = "/home/shika";
    shell = pkgs.fish;
  };
}
