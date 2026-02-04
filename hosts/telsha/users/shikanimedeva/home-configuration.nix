{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  configDir =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "Library/Application Support"
    else
      removePrefix config.home.homeDirectory config.xdg.configHome;

  saplingConfigDir =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "Library/Preferences/sapling"
    else
      removePrefix config.home.homeDirectory "${config.xdg.configHome}/sapling";
in
{
  imports = [
    ../../../../modules/home/base.nix
    ../../../../modules/home/cloud.nix
    ../../../../modules/home/fontconfig.nix
    ../../../../modules/home/ghostty.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/starship.nix
    ../../../../modules/home/vcs.nix
    ../../../../modules/home/workstation.nix
  ];

  home = {
    file = {
      "${configDir}/cachix/cachix.dhall".source =
        config.lib.file.mkOutOfStoreSymlink config.sops.secrets.cachix-config.path;
      "${configDir}/glab-cli/config.yml".source =
        config.lib.file.mkOutOfStoreSymlink config.sops.secrets.glab-cli-config.path;
      "${configDir}/jj/conf.d/default.toml".source =
        config.lib.file.mkOutOfStoreSymlink config.sops.secrets.jujutsu-config.path;
      "${saplingConfigDir}/sapling.conf".source =
        config.lib.file.mkOutOfStoreSymlink config.sops.secrets.sapling-config.path;
    };
    sessionVariables = {
      GHSTACKRC_PATH = config.lib.file.mkOutOfStoreSymlink config.sops.secrets.ghstack-config.path;
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
    };
  };

  nix.extraOptions = ''
    !include ${config.sops.secrets.nix-config.path}
  '';

  programs = {
    bash.enable = true;

    git = {
      includes = [
        { path = config.lib.file.mkOutOfStoreSymlink config.sops.secrets.git-config.path; }
      ];
      signing = {
        format = "openpgp";
        signByDefault = true;
      };
    };

    zsh.enable = true;
  };

  sops = {
    age.keyFile = "${configDir}/sops/age/keys.txt";
    defaultSopsFile = ../../../../secrets/telsha.enc.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      cachix-config = { };
      ghstack-config.mode = "0640";
      git-config = { };
      jujutsu-config = { };
      glab-cli-config = { };
      nix-config = { };
      sapling-config = { };
    };
  };
}
