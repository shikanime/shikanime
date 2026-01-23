{ config, ... }:

{
  imports = [
    ../../../../modules/home/base.nix
    ../../../../modules/home/cloud.nix
    ../../../../modules/home/fontconfig.nix
    ../../../../modules/home/ghostty.nix
    ../../../../modules/home/starship.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/vcs.nix
    ../../../../modules/home/workstation.nix
  ];

  home = {
    file."Library/Preferences/sapling/sapling.conf".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.sapling-config.path;
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

    docker-cli.settings.credsStore = "osxkeychain";

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
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ../../../../secrets/kaltashar.enc.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      cachix-config = { };
      ghstack-config.mode = "0640";
      git-config = { };
      glab-cli-config = { };
      jujutsu-config = { };
      nix-config = { };
      sapling-config = { };
    };
  };

  xdg.configFile = {
    "cachix/cachix.dhall".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.cachix-config.path;
    "glab-cli/config.yml".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.glab-cli-config.path;
    "jj/conf.d/default.toml".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.jujutsu-config.path;
  };
}
