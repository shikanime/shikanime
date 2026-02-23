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
                if [ -z "$1" ]; then
                  set -- "submit"
                fi
                if [ "$1" = "submit" ]; then
                  ${getExe pkgs.jujutsu} abandon -r 'stack() & nulls()'
                  ${getExe pkgs.jujutsu} rebase -d 'trunk()'
                fi
                ${getExe pkgs.ghstack} "$@"
              '';
            in
            [
              "util"
              "exec"
              "--"
              "${ghstack}"
            ];
          restack = [
            "rebase"
            "--onto"
            "trunk()"
            "--source"
            "roots(trunk()..) & mutable()"
          ];
        };
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
          "stack()" = "trunk().. & ~mine()";
        };
        ui = {
          default-command = "log";
          merge-editor = ":builtin";
        };
      };
    };
  };
}
