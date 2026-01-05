{ config, ... }:

{
  imports = [
    ../../../../modules/home/base.nix
    ../../../../modules/home/cloud.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/starship.nix
    ../../../../modules/home/vcs.nix
    ../../../../modules/home/workstation.nix
  ];

  home.sessionVariables.GHSTACKRC_PATH = "${config.xdg.configHome}/ghstack/ghstackrc";

  nix.extraOptions = ''
    !include ${config.sops.secrets.nix-config.path}
  '';

  programs = {
    bash.enable = true;

    docker-cli.settings.credsStore = "secretservice";

    git = {
      includes = [
        { path = config.lib.file.mkOutOfStoreSymlink config.sops.secrets.git-config.path; }
      ];

      # Re-use Windows credentials
      settings.credential.helper = "/mnt/c/Users/${config.home.username}/scoop/shims/git-credential-manager.exe";

      signing = {
        format = "openpgp";
        signByDefault = true;
      };
    };
  };

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ../../../../secrets/nixtar.enc.yaml;
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
    "sapling/sapling.conf".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.sapling-config.path;
    "cachix/cachix.dhall".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.cachix-config.path;
    "ghstack/ghstackrc".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.ghstack-config.path;
    "jj/conf.d/default.toml".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.jujutsu-config.path;
  };
}
