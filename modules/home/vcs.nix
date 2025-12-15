{
  lib,
  pkgs,
  ...
}:

{
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
          ab = [ "absorb" ];
          ci = [ "commit" ];
          ds = [ "describe" ];
          sq = [ "squash" ];
        };
        git.private-commits = "description(glob:'secret:*')";
        templates = {
          commit_trailers = ''
            format_signed_off_by_trailer(self)
            ++ if(!trailers.contains_key("Change-Id"), format_gerrit_change_id_trailer(self))
          '';
          git_push_bookmark = "\"trunks/shikanime/\" ++ change_id.short()";
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
        ui = {
          default-command = "log";
          merge-editor = ":builtin";
        };
      };
    };
  };
}
