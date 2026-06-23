# Project

This repository is a small Nix-flake-based personal profile repo. The current
top-level files are:

- `README.md` - profile content rendered on GitHub
- `flake.nix` - flake wiring for devenv, devlib, git hooks, and treefmt
- `.envrc` - direnv entry point that loads the flake shell
- `CODE_OF_CONDUCT.md` - repository code of conduct
- `LICENSE` - Apache-2.0 license text

**Primary language:** Nix

## Environment

- Use `direnv allow` or `nix develop` to enter the dev shell.
- The flake follows `nixpkgs-unstable` and imports `devenv`, `devlib`,
  `git-hooks`, and `treefmt-nix`.
- `flake.nix` includes Cachix substituters for `cachix`, `devenv`, `shikanime`,
  and `shikanime-studio`.

## Workflow

- Prefer `rtk`-prefixed shell commands because the repo-wide RTK guidance
  requires it.
- Run `nix fmt` before shipping formatting changes.
- Run `nix flake check` before submitting changes.
- Keep Markdown lines wrapped at 80 columns.

## Commit Style

- Use a plain-text capitalized title with no conventional-commit prefix.
- Include body labels when relevant: `Design:`, `Related:`, `Closes #`.

## Notes

- There is no application source tree here; changes are usually limited to
  repository metadata and documentation.
- Keep compatibility with the existing profile content and flake setup.
