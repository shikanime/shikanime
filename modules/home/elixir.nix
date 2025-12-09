{ pkgs, ... }:

{
  home.packages = [
    pkgs.beam28Packages.elixir-ls
    pkgs.elixir
    pkgs.erlang
  ];
}
