{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      theme = "Catppuccin Latte";
      vim_mode = "helix";
      relative_line_numbers = true;
      cursor_shape = "bar";
      indent_guides.enabled = true;
      active_pane_modifiers.highlight_current_line = true;
      soft_wrap = "none";
      show_whitespaces = "selection";
    };

    userKeymaps = [
      {
        context = "Editor && vim_mode == helix_normal";
        bindings = {
          # Core Navigation (NEUI Cluster)
          "n" = "vim::Left";
          "e" = "vim::Down";
          "u" = "vim::Up";
          "i" = "vim::Right";

          # Displaced Commands Restoration
          "h" = "vim::HelixInsert";
          "j" = "vim::NextWordEnd";
          "J" = null; # no vim::NextLongWordEnd in Zed
          "k" = "vim::MoveToNext";
          "K" = "vim::MoveToPrevious";
          "l" = "vim::Undo";
          "L" = "vim::Redo";

          # Utility
          "H" = "vim::InsertFirstNonWhitespace";
          "E" = "vim::JoinLines";
          "N" = "vim::HelixKeepNewestSelection";
          "U" = null; # block default redo (moved to L)
          "I" = null; # block default insert-at-line-start (moved to H)

          # GoTo Mode Optimization
          "g n" = "vim::StartOfLine";
          "g i" = "vim::EndOfLine";
          "g u" = "vim::StartOfDocument";
          "g e" = "vim::EndOfDocument";

          # View Mode Optimization
          "z u" = "vim::ScrollUp";
          "z e" = "vim::ScrollDown";
        };
      }
      {
        context = "Editor && vim_mode == helix_select";
        bindings = {
          # Core Navigation (Extend)
          "n" = "vim::Left";
          "e" = "vim::Down";
          "u" = "vim::Up";
          "i" = "vim::Right";

          # Restoration
          "h" = "vim::HelixInsert";
          "j" = "vim::NextWordEnd";
          "J" = null; # no vim::NextLongWordEnd in Zed
          "k" = "vim::MoveToNext";
          "K" = "vim::MoveToPrevious";
          "l" = "vim::Undo";
          "L" = "vim::Redo";

          # Utility
          "H" = "vim::InsertFirstNonWhitespace";
          "E" = "vim::JoinLines";
          "N" = "vim::HelixKeepNewestSelection";
          "U" = null; # block default redo (moved to L)
          "I" = null; # block default insert-at-line-start (moved to H)

          # GoTo Mode (Extend) — u/e also work in select context
          "g n" = "vim::StartOfLine";
          "g i" = "vim::EndOfLine";
          "g u" = "vim::StartOfDocument";
          "g e" = "vim::EndOfDocument";

          # View Mode — scroll while extending selection
          "z u" = "vim::ScrollUp";
          "z e" = "vim::ScrollDown";
        };
      }
    ];
  };
}
