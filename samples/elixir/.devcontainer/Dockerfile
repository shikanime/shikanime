FROM docker.pkg.github.com/shikanime/shikanime/catbox:0.3.2-erlang-debian-bullseye-20210111 AS base

# Add ASDF Erlang/Elixir and Java dependency plugin
RUN asdf plugin-add erlang \
  && asdf plugin-add elixir
