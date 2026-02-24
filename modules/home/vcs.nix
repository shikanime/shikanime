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
                if [ -z "$1" ] || [ "$1" = "submit" ]; then
                  ${getExe pkgs.jujutsu} abandon -r 'stack() & nulls()'
                  ${getExe pkgs.jujutsu} rebase -d 'trunk()'
                fi
                readarray -t pull_requests < <(
                  ${getExe pkgs.ghstack} "$@" --short | ${getExe pkgs.gnugrep} -o 'https://github.com/.*/pull/[0-9]*'
                )
                for pr in "''${pull_requests[@]}"; do
                  head_ref=$(${getExe pkgs.gh} pr view "$pr" --json headRefName --jq '.headRefName')
                  head_bookmark="''${head_ref#refs/heads/}"
                  orig_bookmark="''${head_bookmark%/head}/orig"
                  ${getExe pkgs.jujutsu} bookmark track "''${orig_bookmark}"
                done
              '';
            in
            [
              "util"
              "exec"
              "--"
              "${ghstack}"
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
