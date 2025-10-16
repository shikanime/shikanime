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

  home-manager.users.vscode.imports = [
    ./users/vscode/home-configuration.nix
  ];

  users.users.vscode = {
    initialHashedPassword = "";
    isNormalUser = true;
    extraGroups = ["wheel"];
    home = "/home/shika";
  };
}
