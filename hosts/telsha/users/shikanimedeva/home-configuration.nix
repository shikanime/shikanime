{ config, pkgs, ... }:

{
  imports = [
    ../../../../modules/home/base.nix
    ../../../../modules/home/cloud.nix
    ../../../../modules/home/elixir.nix
    ../../../../modules/home/ghostty.nix
    ../../../../modules/home/starship.nix
    ../../../../modules/home/go.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/nix.nix
    ../../../../modules/home/nodejs.nix
    ../../../../modules/home/python.nix
    ../../../../modules/home/rustup.nix
    ../../../../modules/home/unix.nix
    ../../../../modules/home/vcs.nix
    ../../../../modules/home/workstation.nix
  ];

  home = {
    file."Library/Preferences/sapling/sapling.conf".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.sapling-config.path;
    sessionPath = [
      "${config.home.homeDirectory}/.rd/bin"
    ];
    sessionVariables = {
      GHSTACKRC_PATH = config.lib.file.mkOutOfStoreSymlink config.sops.secrets.ghstack-config.path;
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
    };
  };

  launchd.agents = {
    chmod-ghstack = {
      enable = true;
      config = {
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        ProgramArguments = [
          "${pkgs.coreutils}/bin/chmod"
          "0640"
          "${config.xdg.configHome}/ghstack/ghstackrc"
        ];
        RunAtLoad = true;
        WatchPaths = [ "${config.xdg.configHome}/ghstack/ghstackrc" ];
      };
    };

    chmod-glab-cli = {
      enable = true;
      config = {
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        ProgramArguments = [
          "${pkgs.coreutils}/bin/chmod"
          "0600"
          "${config.xdg.configHome}/glab-cli/config.yml"
        ];
        RunAtLoad = true;
        WatchPaths = [ "${config.xdg.configHome}/glab-cli/config.yml" ];
      };
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
    defaultSopsFile = ../../../../secrets/telsha.enc.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      cachix-config = { };
      ghstack-config = { };
      git-config = { };
      jujutsu-config = { };
      glab-cli-config = { };
      nix-config = { };
      sapling-config = { };
    };
  };

  xdg.configFile = {
    "cachix/cachix.dhall".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.cachix-config.path;
    "glab-cli/config.yml" = {
      force = true;
      source = config.lib.file.mkOutOfStoreSymlink config.sops.secrets.glab-cli-config.path;
    };
    "jj/conf.d/default.toml".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.jujutsu-config.path;
  };
}
