{ pkgs ? import <nixpkgs> { }, name ? "oceando", tag ? "latest", nixosConfigurations }:

pkgs.dockerTools.buildImage {
  inherit name tag;
  contents = nixosConfigurations.oceando.config.system.build.toplevel;
  config.Entrypoint = [ "/init" ];
}
