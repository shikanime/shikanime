{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.devas = import ../../nixpkgs/home.nix;
  };
}
