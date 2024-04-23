{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../profiles/workstation.nix
    ../profiles/syncthing.nix
    ../profiles/jetbrains.nix
    ../profiles/vscode.nix
    ../users/vscode.nix
  ];

  networking.hostName = "oceando";
}
