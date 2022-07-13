{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/headless.nix"
  ];

  networking.hostName = "elvengard";
}
