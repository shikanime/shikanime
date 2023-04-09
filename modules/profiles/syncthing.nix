{ lib, ... }:

with lib;

{
  # Configure the kernel
  boot.kernel.sysctl = {
    "kernel.threads-max" = mkDefault 8192;
    "fs.inotify.max_user_watches" = mkDefault 204800;
    "fs.file-max" = mkDefault 131072;
    "vm.max_map_count" = mkDefault 524288;
  };

  # Increase security limits
  security.pam.loginLimits = [
    { domain = "*"; item = "nofile"; type = "-"; value = "131072"; }
    { domain = "*"; item = "nproc"; type = "-"; value = "8192"; }
  ];

  # P2P file synchronization
  services.syncthing = {
    enable = true;
    relay.enable = true;
    devices = {
      Altashar = {
        id = "RK4UC45-4KD5VQ5-EIV5OMV-LTJLSBV-R5KZ3WU-FGWLOXA-M7X4D3I-NUPBXAH";
        name = "Altashar";
        introducer = true;
      };
      Ishtar = {
        id = "GEEMT4X-4PECGER-AGXUK6Y-5CNS7ZU-LEKA7SC-YZDXSDO-PTOXWAQ-N5SZGAG";
        name = "Ishtar";
        introducer = true;
      };
      Olva = {
        id = "TXGR6NJ-MXBKE3W-CDAKTK5-6DT57PO-7D6H5PQ-2YQFOSD-W6MCNCP-B76SLAX";
        name = "Olva";
        introducer = true;
      };
      Elkia = {
        id = "L57TP3T-6TFLJLZ-SBCUSE5-SPKXVMU-SLMPO2N-7VF5CA7-S5DSJPJ-RLZQ7Q3";
        name = "Elkia";
      };
      ElvenGard = {
        id = "EJSFAVT-V4JWHW5-T2DBKNU-B52SKTO-XANEOTL-2TWBGEO-PGR624H-YROWTQS";
        name = "ElvenGard";
      };
    };
  };
}
