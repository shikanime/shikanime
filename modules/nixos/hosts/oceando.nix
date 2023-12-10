{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/docker-container.nix"
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../profiles/editor.nix
    ../profiles/workstation.nix
    ../profiles/syncthing.nix
    ../profiles/jetbrains.nix
    ../profiles/vscode.nix
    ../users/vscode.nix
  ];

  environment.noXlibs = false;

  documentation = {
    enable = true;
    doc.enable = true;
    info.enable = true;
    man.enable = true;
    nixos.enable = true;
  };

  programs.command-not-found.enable = true;

  # Iptables do not work in Docker.
  networking.firewall.enable = false;

  # Socket activated ssh presents problem in Docker.
  services.openssh.startWhenNeeded = false;

  networking.hostName = "oceando";
}
