{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.gitnr;

  # Convert template list to gitnr command arguments
  templateArgs = lib.concatStringsSep " " cfg.templates;

  # Generate .gitignore content using gitnr
  gitignoreContent =
    pkgs.runCommand "gitignore-content"
      {
        buildInputs = [ cfg.package ];
      }
      ''
        ${cfg.package}/bin/gitnr create ${templateArgs} > $out
      '';
in
{
  options.gitignore = {
    enable = lib.mkEnableOption "gitignore generator";

    templates = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [
        "tt:linux"
        "tt:macos"
        "tt:windows"
      ];
      description = ''
        List of templates to include in the .gitignore file.

        Supported prefixes:
        - repo: - GitHub repository path (e.g., repo:github/gitignore/refs/heads/main/Nix.gitignore)
        - tt: - TopTal template (e.g., tt:go, tt:jetbrains+all)
        - gh: - GitHub template (e.g., gh:Node)
        - ghc: - GitHub community template (e.g., ghc:JavaScript/Vue)
        - url: - Remote URL (e.g., url:https://domain.com/template.gitignore)
        - file: - Local file (e.g., file:path/to/local.template.gitignore)

        Templates without prefixes default to GitHub templates.
      '';
    };

    outputPath = lib.mkOption {
      type = lib.types.str;
      default = ".gitignore";
      description = "Path where the .gitignore file should be generated";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [ cfg.package ];

    enterShell = lib.mkIf (cfg.templates != [ ]) ''
      touch "${cfg.outputPath}"
      ${cfg.package}/bin/gitnr create ${templateArgs} -f ${cfg.outputPath}
    '';
  };
}
