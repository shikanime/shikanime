{ dockerTools
, name ? "oceando"
, tag ? "latest"
, nixosConfigurations
}:

dockerTools.buildImage {
  inherit name tag;
  contents = nixosConfigurations.oceando.config.system.build.toplevel;
  config.Entrypoint = [ "/init" ];
}
