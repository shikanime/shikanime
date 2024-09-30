{ modulesPath, ... }:

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

  # Enable disk auto-mounting
  systemd.mounts = [
    {
      what = "/dev/disk/by-label/flandre";
      where = "/mnt/flandre";
      description = "Mount Flandre";
    }
    {
      what = "/dev/disk/by-label/remilia";
      where = "/mnt/remilia";
      description = "Mount Remilia";
    }
  ];
  systemd.automounts = [
    {
      where = "/mnt/flandre";
      description = "Automount Flandre";
      wantedBy = [ "multi-user.target" ];
    }
    {
      where = "/mnt/remilia";
      description = "Automount Remilia";
      wantedBy = [ "multi-user.target" ];
    }
  ];
}
