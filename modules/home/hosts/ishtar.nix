{ pkgs, ... }:

{
  imports = [
../../home/identities/sfeir.nix
../../home/profiles/base.nix
../../home/profiles/editor.nix
../../home/profiles/workstation.nix
../../home/profiles/xdg.nix
../../home/profiles/vcs.nix
../../home/profiles/cloud.nix
../../home/profiles/javascript.nix
../../home/profiles/java.nix
../../home/profiles/python.nix
../../home/profiles/native.nix
../../home/profiles/beam.nix
../../home/profiles/go.nix
  ];

  home = {
    homeDirectory = "/home/shika";
    username = "shika";
    packages = [ pkgs.wslu ];
  };

  nix.package = pkgs.nix;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    defaultCacheTtl = 4 * 60 * 60;
  };

  targets.genericLinux.enable = true;

  programs.git.extraConfig.credential.helper =
    "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";

  # CUDA support
  home.sessionVariables.LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
}
