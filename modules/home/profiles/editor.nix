{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = [
      pkgs.vimPlugins.lush-nvim
      pkgs.vimPlugins.vim-colemak
      pkgs.vimPlugins.vim-fugitive
      pkgs.vimPlugins.vim-gitgutter
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-commentary
      pkgs.vimPlugins.vim-surround
      pkgs.vimPlugins.vim-repeat
      pkgs.vimPlugins.nerdtree
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.fzf-vim
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
        json
        toml
        make
        markdown
        rst
        dot
        nix
        comment
        diff
        git_rebase
        gitattributes
        jq
        markdown_inline
        regex
        vim
      ]))
    ];
    extraConfig = ''
      set number relativenumber
    '';
  };

  programs.helix = {
    enable = true;
    settings.keys = {
      normal = {
        "n" = "move_char_left";
        "e" = "move_line_down";
        "i" = "move_line_up";
        "o" = "move_char_right";
        "h" = "insert_mode";
        "H" = "insert_at_line_start";
        "l" = "open_below";
        "L" = "open_above";
        "k" = "move_next_word_end";
        "K" = "move_next_long_word_end";
        "j" = "search_next";
        "J" = "search_prev";
        "g" = {
          "n" = "goto_line_start";
          "o" = "goto_line_end";
        };
        "space" = {
          "w" = {
            "n" = "jump_view_left";
            "e" = "jump_view_down";
            "i" = "jump_view_up";
            "o" = "jump_view_right";
          };
        };
        "C-w" = {
          "n" = "jump_view_left";
          "e" = "jump_view_down";
          "E" = "join_selections";
          "A-E" = "join_selections_space";
          "i" = "jump_view_up";
          "I" = "keep_selections";
          "A-I" = "remove_selections";
          "o" = "jump_view_right";
        };
        "z" = {
          "e" = "scroll_down";
          "i" = "scroll_up";
        };
        "Z" = {
          "e" = "scroll_down";
          "i" = "scroll_up";
        };
      };
      insert = {
        "A-x" = "normal_mode";
      };
      select = {
        "n" = "move_char_left";
        "e" = "move_line_down";
        "i" = "move_line_up";
        "o" = "move_char_right";
        "h" = "insert_mode";
        "H" = "insert_at_line_start";
        "l" = "open_below";
        "L" = "open_above";
        "k" = "move_next_word_end";
        "K" = "move_next_long_word_end";
        "j" = "search_next";
        "J" = "search_prev";
      };
    };
  };
}
