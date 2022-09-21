{
  # Configure Home Manager to use NixOS global packages
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # Add ~/.local/bin/ to $PATH
  environment.localBinInPath = true;
}
