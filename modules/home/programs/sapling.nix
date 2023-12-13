{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.sapling;
in
{
  meta.maintainers = [ maintainers.shikanime ];

  options = {
    programs.sapling = {
      enable = mkEnableOption "Sapling";

      package = mkPackageOption pkgs "sapling" { };

      userName = mkOption {
        type = types.str;
        description = "Default user name to use.";
      };

      userEmail = mkOption {
        type = types.str;
        description = "Default user email to use.";
      };

      extraConfig = mkOption {
        type = types.attrsOf types.anything;
        default = { };
        description = "Additional configuration to add.";
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = [ cfg.package ];

      programs.sapling.extraConfig.ui = {
        username = cfg.userName + " <" + cfg.userEmail + ">";
      };
    }

    (mkIf (!pkgs.stdenv.isDarwin) {
      xdg.configFile."sapling/sapling.conf".text =
        lib.generators.toINI { } cfg.extraConfig;
    })
    (mkIf (pkgs.stdenv.isDarwin) {
      home.file."Library/Preferences/sapling/sapling.conf".text =
        lib.generators.toINI { } cfg.extraConfig;
    })

    (mkIf (lib.isString cfg.extraConfig && !pkgs.stdenv.isDarwin) {
      xdg.configFile."sapling/sapling.conf".text = cfg.extraConfig;
    })
    (mkIf (lib.isString cfg.extraConfig && pkgs.stdenv.isDarwin) {
      home.file."Library/Preferences/sapling/sapling.conf".text =
        cfg.extraConfig;
    })
  ]);
}
