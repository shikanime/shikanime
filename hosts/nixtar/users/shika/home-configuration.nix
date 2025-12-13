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

  home.sessionVariables.GHSTACKRC_PATH = config.lib.file.mkOutOfStoreSymlink config.sops.secrets.ghstack-config.path;

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
      ghstack-config = { };
      git-config = { };
      glab-cli-config = { };
      jujutsu-config = { };
      nix-config = { };
      sapling-config = { };
    };
  };

  # Use systemd-tmpfiles to ensure glab config is a real file with mode 0600
  systemd.user.tmpfiles.rules =
    let
      glabConfigTarget = "${config.xdg.configHome}/glab-cli/config.yml";
      ghstackConfigTarget = "${config.xdg.configHome}/ghstack/ghstackrc";
    in
    [
      "C+ ${glabConfigTarget} - - - - ${config.sops.secrets.glab-cli-config.path}"
      "z  ${glabConfigTarget} 0600"
      "C+ ${ghstackConfigTarget} - - - - ${config.sops.secrets.ghstack-config.path}"
      "z  ${ghstackConfigTarget} 0640"
    ];

  xdg.configFile = {
    "sapling/sapling.conf".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.sapling-config.path;
    "cachix/cachix.dhall".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.cachix-config.path;
    "jj/conf.d/default.toml".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.secrets.jujutsu-config.path;
  };
}
