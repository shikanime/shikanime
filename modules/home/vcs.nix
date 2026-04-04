{ lib, pkgs, ... }:

with lib;

{
  home.packages = [
    pkgs.git-credential-manager
  ];

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        alias = {
          adog = "log --all --decorate --oneline --graph";
          filing = "commit --amend --signoff --no-edit --reset-author";
          poi = "commit --amend --no-edit";
          pouf = "push --force-with-lease";
          refiling = "rebase --exec 'git filing'";
          tape = "push --mirror";
        };
        advice.skippedCherryPicks = false;
        credential.helper = "manager";
        core.editor = "${lib.getExe pkgs.helix}";
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        rebase = {
          autostash = true;
          updateRefs = true;
        };
      };
    };

    jujutsu = {
      enable = true;
      settings = {
        aliases = {
          ghstack =
            let
              ghstack = pkgs.writeShellScript "jj-ghstack" ''
                set -eu

                jj=${getExe pkgs.jujutsu}
                git=${getExe pkgs.git}
                ghstack=${getExe pkgs.ghstack}
                ghstack_config_path=''${GHSTACKRC_PATH:-"$HOME/.ghstackrc"}

                resolve_remote_name() {
                  ghstack_config_path=$1

                  [ -f "$ghstack_config_path" ] || {
                    printf '%s\n' origin
                    return 0
                  }

                  ${getExe' pkgs.yq-go "yq"} -p ini -o json -r '.ghstack.remote_name // "origin"' "$ghstack_config_path"
                }

                track_stack_bookmarks() {
                  remote_name=$1
                  stack_commit_ids=$("$jj" log --no-graph -r 'stack()' -T 'commit_id ++ "\n"')
                  [ -n "$stack_commit_ids" ] || return 0

                  "$git" for-each-ref \
                    --format='%(refname:strip=3)|%(objectname)' \
                    "refs/remotes/''${remote_name}/gh/*/orig" \
                    | while IFS='|' read -r bookmark_name commit_id; do
                    [ -n "$bookmark_name" ] || continue
                    printf '%s\n' "$stack_commit_ids" | ${getExe' pkgs.gnugrep "grep"} -Fxq "$commit_id" || continue
                    "$jj" bookmark track "''${bookmark_name}@''${remote_name}" >/dev/null
                  done
                }

                sync_stack_bookmarks() {
                  remote_name=$1
                  "$jj" git fetch --remote "$remote_name"
                  track_stack_bookmarks "$remote_name"
                }

                prepare_submit() {
                  remote_name=$1
                  sync_stack_bookmarks "$remote_name"
                  "$jj" abandon -r 'stack() & nulls()'
                  "$jj" rebase -d 'trunk()'
                }

                remote_name=$(resolve_remote_name "$ghstack_config_path")

                if [ -z "''${1:-}" ]; then
                  set -- "submit"
                fi
                if [ "$1" = "submit" ]; then
                  prepare_submit "$remote_name"
                fi
                "$ghstack" "$@"
                if [ "$1" = "submit" ]; then
                  sync_stack_bookmarks "$remote_name"
                fi
              '';
            in
            [
              "util"
              "exec"
              "--"
              "${ghstack}"
            ];
          prune = [
            "abandon"
            "nulls()"
            "conflicts"
          ];
          sync = [
            "git"
            "fetch"
            "--all-remotes"
          ];
          restack = [
            "rebase"
            "--onto"
            "trunk()"
            "--source"
            "roots(trunk()..) & mutable()"
          ];
        };
        git.private-commits = "description(glob:'secret:*')";
        templates = {
          commit_trailers = ''
            format_signed_off_by_trailer(self)
            ++ if(!trailers.contains_key("Change-Id"), format_gerrit_change_id_trailer(self))
          '';
          git_push_bookmark = "\"shikanime/push-\" ++ change_id.short()";
        };
        merge-tools.trae = {
          merge-args = [
            "--wait"
            "--merge"
            "$left"
            "$right"
            "$base"
            "$output"
          ];
          merge-tool-edits-conflict-markers = true;
          conflict-marker-style = "git";
        };
        revset-aliases = {
          "nulls()" = "empty() & mutable()";
          "stack()" = "stack(@)";
          "stack(x)" = "stack(x, 2)";
          "stack(x, n)" = "ancestors(reachable(x, mutable()), n)";
        };
        ui = {
          default-command = "log";
          merge-editor = ":builtin";
        };
      };
    };
  };
}
