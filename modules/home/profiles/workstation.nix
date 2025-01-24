{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

{
  xdg.enable = true;

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.packages = [
    pkgs.cachix
    pkgs.gnupatch
    pkgs.gnumake
    pkgs.gnused
    pkgs.gnugrep
    pkgs.less
    pkgs.zip
    pkgs.unzip
    pkgs.which
    pkgs.bzip2
    pkgs.graphviz
    pkgs.rsync
    pkgs.curl
    pkgs.wget
    pkgs.watch
    pkgs.pprof
  ];

  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.vim-colemak
    ];
  };

  programs.helix = {
    enable = true;
    languages = {
      language-server.lsp-ai = {
        command = "${pkgs.lsp-ai}/bin/lsp-ai";
        config = {
          memory.file_store = { };
          models.deepseek-coder = {
            type = "ollama";
            path = "deepseek-coder";
          };
          completion.model = "deepseek-coder";
        };
      };
      language = [
        {
          name = "python";
          language-servers = [ "lsp-ai" ];
        }
        {
          name = "go";
          language-servers = [ "lsp-ai" ];
        }
        {
          name = "javascript";
          language-servers = [ "lsp-ai" ];
        }
      ];
    };
    settings = {
      theme = "catppuccin_latte";

      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          render = true;
        };
      };

      keys.normal = {
        # N <=> K (K is in the QWERTY N position)
        n = "move_char_left";
        N = "keep_selections";
        k = "search_next";
        K = "search_prev";
        # E <=> J (J now 'jumps words')
        e = "move_line_down";
        E = "join_selections";
        j = "move_next_word_end";
        J = "move_next_long_word_end";
        # H <=> I (H is just a sideways I)
        i = "move_char_right";
        I = "no_op";
        h = "insert_mode";
        H = "insert_at_line_start";
        # U <=> L (L is in the QWERTY U position)
        u = "move_line_up";
        U = "no_op";
        l = "undo";
        L = "redo";
      };

      keys.select = {
        # N <=> K (K is in the QWERTY N position)
        n = "extend_char_left";
        N = "keep_selections";
        k = "extend_search_next";
        K = "extend_search_prev";
        # E <=> J (J now 'jumps words')
        e = "extend_visual_line_down";
        E = "join_selections";
        j = "extend_next_word_end";
        J = "extend_next_long_word_end";
        # H <=> I (H is just a sideways I)
        i = "extend_char_right";
        I = "no_op";
        h = "insert_mode";
        H = "insert_at_line_start";
        # U <=> L (L is in the QWERTY U position)
        u = "extend_visual_line_up";
        U = "no_op";
        l = "undo";
        L = "redo";
      };
    };
    themes.catppuccin_latte = {
      attribute = "yellow";

      type = "yellow";
      "type.enum.variant" = "teal";

      constructor = "sapphire";

      constant = "peach";
      "constant.character" = "teal";
      "constant.character.escape" = "pink";

      string = "green";
      "string.regexp" = "pink";
      "string.special" = "blue";
      "string.special.symbol" = "red";

      comment = {
        fg = "overlay2";
        modifiers = [ "italic" ];
      };

      variable = "text";
      "variable.parameter" = {
        fg = "maroon";
        modifiers = [ "italic" ];
      };
      "variable.builtin" = "red";
      "variable.other.member" = "blue";

      label = "sapphire";

      punctuation = "overlay2";
      "punctuation.special" = "sky";

      keyword = "mauve";
      "keyword.control.conditional" = {
        fg = "mauve";
        modifiers = [ "italic" ];
      };

      operator = "sky";

      function = "blue";
      "function.macro" = "mauve";

      tag = "blue";

      namespace = {
        fg = "yellow";
        modifiers = [ "italic" ];
      };

      special = "blue";

      "markup.heading.1" = "red";
      "markup.heading.2" = "peach";
      "markup.heading.3" = "yellow";
      "markup.heading.4" = "green";
      "markup.heading.5" = "blue";
      "markup.heading.6" = "mauve";
      "markup.list" = "teal";
      "markup.list.unchecked" = "overlay2";
      "markup.list.checked" = "green";
      "markup.bold" = {
        fg = "red";
        modifiers = [ "bold" ];
      };
      "markup.italic" = {
        fg = "red";
        modifiers = [ "italic" ];
      };
      "markup.link.url" = {
        fg = "blue";
        modifiers = [
          "italic"
          "underlined"
        ];
      };
      "markup.link.text" = "lavender";
      "markup.raw" = "green";
      "markup.quote" = "pink";

      "diff.plus" = "green";
      "diff.minus" = "red";
      "diff.delta" = "blue";

      "ui.background" = {
        fg = "text";
        bg = "base";
      };

      "ui.linenr" = {
        fg = "surface1";
      };
      "ui.linenr.selected" = {
        fg = "lavender";
      };

      "ui.statusline" = {
        fg = "subtext1";
        bg = "mantle";
      };
      "ui.statusline.inactive" = {
        fg = "surface2";
        bg = "mantle";
      };
      "ui.statusline.normal" = {
        fg = "base";
        bg = "lavender";
        modifiers = [ "bold" ];
      };
      "ui.statusline.insert" = {
        fg = "base";
        bg = "green";
        modifiers = [ "bold" ];
      };
      "ui.statusline.select" = {
        fg = "base";
        bg = "flamingo";
        modifiers = [ "bold" ];
      };

      "ui.popup" = {
        fg = "text";
        bg = "surface0";
      };
      "ui.window" = {
        fg = "crust";
      };
      "ui.help" = {
        fg = "overlay2";
        bg = "surface0";
      };

      "ui.bufferline" = {
        fg = "subtext0";
        bg = "mantle";
      };
      "ui.bufferline.active" = {
        fg = "mauve";
        bg = "base";
        underline = {
          color = "mauve";
          style = "line";
        };
      };
      "ui.bufferline.background" = {
        bg = "crust";
      };

      "ui.text" = "text";
      "ui.text.focus" = {
        fg = "text";
        bg = "surface0";
        modifiers = [ "bold" ];
      };
      "ui.text.inactive" = {
        fg = "overlay1";
      };
      "ui.text.directory" = {
        fg = "blue";
      };

      "ui.virtual" = "overlay0";
      "ui.virtual.ruler" = {
        bg = "surface0";
      };
      "ui.virtual.indent-guide" = "surface0";
      "ui.virtual.inlay-hint" = {
        fg = "surface1";
        bg = "mantle";
      };
      "ui.virtual.jump-label" = {
        fg = "rosewater";
        modifiers = [ "bold" ];
      };

      "ui.selection" = {
        bg = "surface1";
      };

      "ui.cursor" = {
        fg = "base";
        bg = "secondary_cursor";
      };
      "ui.cursor.primary" = {
        fg = "base";
        bg = "rosewater";
      };
      "ui.cursor.match" = {
        fg = "peach";
        modifiers = [ "bold" ];
      };

      "ui.cursor.primary.normal" = {
        fg = "base";
        bg = "rosewater";
      };
      "ui.cursor.primary.insert" = {
        fg = "base";
        bg = "green";
      };
      "ui.cursor.primary.select" = {
        fg = "base";
        bg = "flamingo";
      };

      "ui.cursor.normal" = {
        fg = "base";
        bg = "secondary_cursor_normal";
      };
      "ui.cursor.insert" = {
        fg = "base";
        bg = "secondary_cursor_insert";
      };
      "ui.cursor.select" = {
        fg = "base";
        bg = "secondary_cursor";
      };

      "ui.cursorline.primary" = {
        bg = "cursorline";
      };

      "ui.highlight" = {
        bg = "surface1";
        modifiers = [ "bold" ];
      };

      "ui.menu" = {
        fg = "overlay2";
        bg = "surface0";
      };
      "ui.menu.selected" = {
        fg = "text";
        bg = "surface1";
        modifiers = [ "bold" ];
      };

      "diagnostic.error" = {
        underline = {
          color = "red";
          style = "curl";
        };
      };
      "diagnostic.warning" = {
        underline = {
          color = "yellow";
          style = "curl";
        };
      };
      "diagnostic.info" = {
        underline = {
          color = "sky";
          style = "curl";
        };
      };
      "diagnostic.hint" = {
        underline = {
          color = "teal";
          style = "curl";
        };
      };
      "diagnostic.unnecessary" = {
        modifiers = [ "dim" ];
      };

      error = "red";
      warning = "yellow";
      info = "sky";
      hint = "teal";

      palette = {
        rosewater = "#dc8a78";
        flamingo = "#dd7878";
        pink = "#ea76cb";
        mauve = "#8839ef";
        red = "#d20f39";
        maroon = "#e64553";
        peach = "#fe640b";
        yellow = "#df8e1d";
        green = "#40a02b";
        teal = "#179299";
        sky = "#04a5e5";
        sapphire = "#209fb5";
        blue = "#1e66f5";
        lavender = "#7287fd";
        text = "#4c4f69";
        subtext1 = "#5c5f77";
        subtext0 = "#6c6f85";
        overlay2 = "#7c7f93";
        overlay1 = "#8c8fa1";
        overlay0 = "#9ca0b0";
        surface2 = "#acb0be";
        surface1 = "#bcc0cc";
        surface0 = "#ccd0da";
        base = "#eff1f5";
        mantle = "#e6e9ef";
        crust = "#dce0e8";

        cursorline = "#e8ecf1";
        secondary_cursor = "#e1a99d";
        secondary_cursor_normal = "#e1a99d";
        secondary_cursor_insert = "#74b867";
      };
    };
  };
  programs.mise = {
    enable = true;
    globalConfig.settings.experimental = true;
  };

  programs.dircolors.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "sudo"
        "docker"
      ];
    };
  };

  programs.zoxide.enable = true;

  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config = { show_banner: false }

      use ${pkgs.nu_scripts}/share/nu_scripts/modules/argx *
      use ${pkgs.nu_scripts}/share/nu_scripts/modules/lg *
      use ${pkgs.nu_scripts}/share/nu_scripts/modules/system *
      use ${pkgs.nu_scripts}/share/nu_scripts/modules/docker *

      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/curl/curl-completions.nu
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/less/less-completions.nu
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/make/make-completions.nu
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/man/man-completions.nu
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/tar/tar-completions.nu
      source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/vscode/vscode-completions.nu
    '';
  };

  programs.starship.enable = true;

  programs.carapace.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    mise.enable = true;
    config.global.load_dotenv = true;
  };

  programs.jq.enable = true;

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
}
