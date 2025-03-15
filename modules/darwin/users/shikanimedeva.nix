{
  home-manager.users.shikanimedeva = {
    imports = [
      ../../home/profiles/base.nix
      ../../home/profiles/beam.nix
      ../../home/profiles/cloud.nix
      ../../home/profiles/desktop.nix
      ../../home/profiles/fish.nix
      ../../home/profiles/go.nix
      ../../home/profiles/helix.nix
      ../../home/profiles/java.nix
      ../../home/profiles/javascript.nix
      ../../home/profiles/python.nix
      ../../home/profiles/rustup.nix
      ../../home/profiles/unix.nix
      ../../home/profiles/vcs.nix
      ../../home/profiles/workstation.nix
    ];

    home = {
      homeDirectory = "/Users/shikanimedeva";
      username = "shikanimedeva";
    };
  };

  users.users.shikanimedeva.home = "/Users/shikanimedeva";
}
