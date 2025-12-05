{ pkgs, ... }:

{
  home.packages = [
    pkgs.elixir
    pkgs.erlang
  ];
}
