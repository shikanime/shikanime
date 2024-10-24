{
  perSystem = { pkgs, ... }: {
    apps = {
      sapling = { type = "app"; program = pkgs.sapling; };
    };
  };
}
