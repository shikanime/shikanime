{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    "${modulesPath}/profiles/headless.nix"
    ../profiles/base.nix
    ../profiles/machine.nix
    ../profiles/cluster.nix
    ../profiles/nishir.nix
  ];

  fileSystems."/mnt/flandre".device = "/dev/disk/by-label/flandre";

  services.k3s.tokenFile = "/mnt/flandre/secrets/k3s-token";

  services.tailscale.authKeyFile = "/mnt/flandre/secrets/tailscale-authkey";

  services.openiscsi.name = "iqn.2011-11.studio.shikanime:flandre";

  services.k3s = {
    role = "agent";
    serverAddr = "remilia";
  };

  networking.hostName = "flandre";
}
