{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    ./nishir-base.nix
  ];

  hardware.raspberry-pi."4" = {
    fkms-3d.enable = true;
    apply-overlays-dtmerge.enable = true;
  };

  # https://github.com/NixOS/nixpkgs/issues/154163#issuecomment-1008362877
  nixpkgs.overlays = [
    (_: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  # Enable Wake-on-LAN on the ethernet port
  networking.interfaces.eth0.wakeOnLan.enable = true;

  # Enable disk auto-mounting
  systemd.mounts = [
    {
      what = "/dev/disk/by-label/Satellite";
      where = "/mnt/satellite";
      description = "Mount the Satellite disk";
    }
    {
      what = "/dev/disk/by-label/Voyager";
      where = "/mnt/voyager";
      description = "Mount the Voyager disk";
    }
  ];
  systemd.automounts = [
    {
      where = "/mnt/satellite";
      description = "Automount the Satellite disk";
      wantedBy = [ "multi-user.target" ];
    }
    {
      where = "/mnt/voyager";
      description = "Automount the Voyager disk";
      wantedBy = [ "multi-user.target" ];
    }
  ];
}
