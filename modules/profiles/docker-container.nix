{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/docker-container.nix"
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
}
