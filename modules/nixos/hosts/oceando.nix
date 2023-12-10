{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/docker-container.nix"
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/hardened.nix"
../../home/profiles/base.nix
../../home/profiles/machine.nix
../../home/profiles/editor.nix
../../home/profiles/workstation.nix
../../home/profiles/syncthing.nix
../../home/profiles/jetbrains.nix
../../home/profiles/vscode.nix
../../home/users/vscode.nix
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
