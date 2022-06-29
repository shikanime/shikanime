{ pkgs ? import <nixpkgs> { }, lib, ... }:

with lib;

{
  # Increase the inotify limit
  boot.kernel.sysctl."fs.inotify.max_user_watches" = mkDefault "204800";

  # P2P file synchronization
  services.syncthing = {
    enable = true;
    relay.enable = true;
    devices = {
      "Altashar" = {
        id = "RK4UC45-4KD5VQ5-EIV5OMV-LTJLSBV-R5KZ3WU-FGWLOXA-M7X4D3I-NUPBXAH";
        name = "Altashar";
        introducer = true;
      };
      "Ishtar" = {
        id = "44E7RLD-RGPT2GJ-ZEKXV2V-KC65JST-O4KE4BE-6OUVCVD-3LTOMDI-DQTTXAH";
        name = "Ishtar";
        introducer = true;
      };
      "Olva" = {
        id = "TXGR6NJ-MXBKE3W-CDAKTK5-6DT57PO-7D6H5PQ-2YQFOSD-W6MCNCP-B76SLAX";
        name = "Olva";
        introducer = true;
      };
      "Elkia" = {
        id = "ZVVBZTP-XDACKVZ-EZLK3BZ-7CDNUXA-ETKDK62-MWTROTP-JYEVSHJ-TM62IAU";
        name = "Elkia";
      };
      "Elven Gard" = {
        id = "WCBMPFF-VJDNWMP-QQAKZVV-6ZO62QN-OYQJ2BZ-WQCGKR6-EC7IW6S-MLWWOAC";
        name = "Elven Gard";
      };
    };
    extraOptions.gui = {
      tls = true;
      user = "syncthing";
      password = "$2a$10$vy0rh/iE4hAtLM4LFxbv1OyMJQiLXUZrLFxrODmI2Ml7kmEvYxjbO";
    };
  };
}
