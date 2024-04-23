{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../profiles/workstation.nix
    ../profiles/syncthing.nix
    ../profiles/jetbrains.nix
    ../profiles/vscode.nix
    ../users/vscode.nix
  ];

  boot.kernelParams = [ "cgroup_enable=memory" ];

  networking.hostName = "elvengard";
}
