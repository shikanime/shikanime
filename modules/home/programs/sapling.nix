{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.sapling;
  iniFormat = pkgs.formats.ini { };
in
{
  meta.maintainers = [ maintainers.shikanime ];

  options = {
    programs.sapling = {
      enable = mkEnableOption "Sapling";

      package = mkPackageOption pkgs "sapling" { };

      settings = mkOption {
        type = types.attrsOf types.anything;
        default = { };
        description = "Additional configuration to add.";
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    { home.packages = [ cfg.package ]; }

    (mkIf (!pkgs.stdenv.isDarwin) {
      xdg.configFile."sapling/sapling.conf".source =
        iniFormat.generate "sapling.conf" cfg.settings;
    })
    (mkIf (pkgs.stdenv.isDarwin) {
      home.file."Library/Preferences/sapling/sapling.conf".source =
        iniFormat.generate "sapling.conf" cfg.settings;
    })
  ]);
}
