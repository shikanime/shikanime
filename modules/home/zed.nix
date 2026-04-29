{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      agent = {
        new_thread_location = "new_worktree";
        default_model = {
          provider = "Hermes Agent";
          model = "hermes-agent";
          enable_thinking = true;
        };
      };

      agent_servers = {
        "Hermes Agent" = {
          type = "custom";
          command = "hermes";
          args = [ "acp" ];
        };
      };

      icon_theme = {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Frappé";
      };

      language_models = {
        openai_compatible = {
          "Hermes Agent" = {
            api_url = "http://localhost:8642/v1";
            available_models = [
              {
                name = "hermes-agent";
                max_tokens = 200000;
                max_output_tokens = 32000;
                max_completion_tokens = 200000;
                capabilities = {
                  tools = true;
                  images = true;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                  chat_completions = true;
                };
              }
            ];
          };
        };
      };

      helix_mode = true;

      relative_line_numbers = "enabled";

      theme = {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Frappé";
      };

      vim_mode = true;
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
