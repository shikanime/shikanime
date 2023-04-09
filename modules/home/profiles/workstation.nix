{ pkgs, lib, ... }:

with lib;

{
  home.packages = [
    pkgs.gnupatch
    pkgs.gnumake
    pkgs.gnused
    pkgs.gnugrep
    pkgs.less
    pkgs.which
    pkgs.bzip2
    pkgs.graphviz
    pkgs.rsync
    pkgs.curl
    pkgs.wget
    pkgs.watch
    pkgs.pprof
    pkgs.nixpkgs-fmt
  ];

  programs.dircolors.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "vim-interaction"
        "sudo"
        "docker"
      ];
    };
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
      let-env config = {
        show_banner: false
      }
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.jq.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = [
      pkgs.vimPlugins.lush-nvim
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
        help
        jq
        markdown_inline
        regex
        vim
      ]))
    ];
    extraConfig = ''
      "  Colemak layout:                  |                 QWERTY layout:
      "  `12345 67890-=     Move around:  |  (instead of)   `12345 67890-=
      "   qwfpg jluy;[]\         e        |       k          qwert yuiop[]\
      "   arstd HNEIo'         h   i      |     h   l        asdfg HJKL;'
      "   zxcvb km,./            n        |       j          zxcvb nm,./

      "  (  novx)  h = h (Left)     i = l (Right)     e = k (Up)     n = j (Down)

      "  (  novx)  l = b (Back word)            L = B (Back WORD)
      "  (  novx)  y = w (Forward word)         Y = W (Forward WORD)
      "  (  novx)  u = e (Forward end of word)  U = E (Forward end of WORD)

      "  (c     )  <C-L> = <C-Left> (Back WORD)
      "  (c     )  <C-Y> = <C-Right> (Seems to equal forward WORD minus 1 character)

      "  (  n  x)  a = v (Visual)   A = V (Visual line)
      "  (  n   )  r = r (Replace)  R = R (Replace)
      "  (  n   )  s = i (Insert)   S = I (Insert before first non-blank of line)
      "  (  n   )  t = a (Append)   T = A (Append at end of line)
      "  (  n   )  w = c (Change)   W = C (Change to end of line)  ww = cc (Change line)

      "  (  n  x)  z = u (Undo)    Z = <C-R> (Redo)  gz = U (Undo all latest changes on line)
      "  (  n  x)  x = x (Cut)     X = dd (Cut line)
      "  (  n  x)  c = y (Copy)    C = yy (Copy line)
      "  (  n  x)  v = p (Paste)   V = P (Paste)
      "  (  n  x)  gv = gp (Paste) gV = gP (Paste)

      "  (   o  )  r = i (Example: dip -> drp (Delete inner paragraph))

      "  (  no x)  p = t{char} (Before next {char})  P = T{char} (After previous {char})
      "  (  no x)  b = ; (Repeat latest f or t)  B = , (Repeat latest f or t reversed)
      "  (  no x)  k = n (Repeat latest / or ?)  K = N (Repeat latest / or ? reversed)

      "  (  n  x)  j = z
      "  (  n  x)  jn = zj (Next fold) [Also jj = zj]
      "  (  n  x)  je = zk (Previous fold) [Also jk = zk]

      "  (  n   )  ga = gv (Reselect last visual selection)
      "  (  n  x)  gK = K (Lookup)
      "  (  n  x)  gL = L (To line [count] from bottom of window)

      "  (  n  x)  <C-W>h = <C-W>h (Window left)
      "  (  n  x)  <C-W>n = <C-W>j (Window down)
      "  (  n  x)  <C-W>e = <C-W>k (Window up)
      "  (  n  x)  <C-W>i = <C-W>l (Window right)

      "  Lost:
      "  (  n  x)  H (To line [count] from top of window)
      "  (  n  x)  s (Substitute [count] characters) [Use wi = cl]
      "  (  n  x)  S (Substitute [count] lines) [Use ww = cc]
      "  (  n  x)  X (Cut [count] characters backwards) [Use dh = dh]
      "  (  n   )  Z (Quit)
      "  (  n  x)  <C-W>n (Window down) [Use <C-W><C-N> = <C-W><C-N>]
      "  (  n  x)  <C-W>i (Window down) [Use <C-W><C-I> = <C-W><C-I>]

      "  Legend:
      "  <C-X>     Ctrl-X
      "  (c     )  Command-line mode
      "  ( i    )  Insert mode
      "  (  n   )  Normal mode
      "  (   o  )  Operator pending
      "  (    v )  Visual+Select mode
      "  (     x)  Visual mode

      " Up/down/left/right {{{
          nnoremap h h|xnoremap h h|onoremap h h|
          nnoremap n j|xnoremap n j|onoremap n j|
          nnoremap e k|xnoremap e k|onoremap e k|
          nnoremap i l|xnoremap i l|onoremap i l|
      " }}}

      " Words forward/backward {{{
          " l/L = back word/WORD
          " u/U = end of word/WORD
          " y/Y = forward word/WORD
          nnoremap l b|xnoremap l b|onoremap l b|
          nnoremap L B|xnoremap L B|onoremap L B|
          nnoremap u e|xnoremap u e|onoremap u e|
          nnoremap U E|xnoremap U E|onoremap U E|
          nnoremap y w|xnoremap y w|onoremap y w|
          nnoremap Y W|xnoremap Y W|onoremap Y W|
          cnoremap <C-L> <C-Left>
          cnoremap <C-Y> <C-Right>
      " }}}

      " inSert/Replace/append (T) {{{
          nnoremap s i|
          nnoremap S I|
          nnoremap t a|
          nnoremap T A|
      " }}}

      " Change {{{
          nnoremap w c|xnoremap w c|
          nnoremap W C|xnoremap W C|
          nnoremap ww cc|
      " }}}

      " Cut/copy/paste {{{
          nnoremap x x|xnoremap x d|
          nnoremap c y|xnoremap c y|
          nnoremap v p|xnoremap v p|
          nnoremap X dd|xnoremap X d|
          nnoremap C yy|xnoremap C y|
          nnoremap V P|xnoremap V P|
          nnoremap gv gp|xnoremap gv gp|
          nnoremap gV gP|xnoremap gV gP|
      " }}}

      " Undo/redo {{{
          nnoremap z u|xnoremap z :<C-U>undo<CR>|
          nnoremap gz U|xnoremap gz :<C-U>undo<CR>|
          nnoremap Z <C-R>|xnoremap Z :<C-U>redo<CR>|
      " }}}

      " Visual mode {{{
          nnoremap a v|xnoremap a v|
          nnoremap A V|xnoremap A V|
          nnoremap ga gv
          " Make insert/add work also in visual line mode like in visual block mode
          xnoremap <silent> <expr> s (mode() =~# "[V]" ? "\<C-V>0o$I" : "I")
          xnoremap <silent> <expr> S (mode() =~# "[V]" ? "\<C-V>0o$I" : "I")
          xnoremap <silent> <expr> t (mode() =~# "[V]" ? "\<C-V>0o$A" : "A")
          xnoremap <silent> <expr> T (mode() =~# "[V]" ? "\<C-V>0o$A" : "A")
      " }}}

      " Search {{{
          " f/F are unchanged
          nnoremap p t|xnoremap p t|onoremap p t|
          nnoremap P T|xnoremap P T|onoremap P T|
          nnoremap b ;|xnoremap b ;|onoremap b ;|
          nnoremap B ,|xnoremap B ,|onoremap B ,|
          nnoremap k n|xnoremap k n|onoremap k n|
          nnoremap K N|xnoremap K N|onoremap K N|
      " }}}

      " inneR text objects {{{
          " E.g. dip (delete inner paragraph) is now drp
          onoremap r i
      " }}}

      " Folds, etc. {{{
          nnoremap j z|xnoremap j z|
          nnoremap jn zj|xnoremap jn zj|
          nnoremap je zk|xnoremap je zk|
      " }}}

      " Overridden keys must be prefixed with g {{{
          nnoremap gX X|xnoremap gX X|
          nnoremap gK K|xnoremap gK K|
          nnoremap gL L|xnoremap gL L|
      " }}}

      " Window handling {{{
          nnoremap <C-W>h <C-W>h|xnoremap <C-W>h <C-W>h|
          nnoremap <C-W>n <C-W>j|xnoremap <C-W>n <C-W>j|
          nnoremap <C-W>e <C-W>k|xnoremap <C-W>e <C-W>k|
          nnoremap <C-W>i <C-W>l|xnoremap <C-W>i <C-W>l|
      " }}}

      set number relativenumber
    '';
  };

  programs.tmux.enable = true;

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "elkia.local" = {
        hostname = "elkia.local";
        user = "vscode";
        forwardX11 = true;
        forwardX11Trusted = true;
        forwardAgent = true;
      };
      "elvengard.local" = {
        hostname = "elvengard.local";
        user = "vscode";
        forwardX11 = true;
        forwardX11Trusted = true;
        forwardAgent = true;
      };
    };
    extraConfig = ''
      AddKeysToAgent yes
    '' + optionalString pkgs.stdenv.hostPlatform.isDarwin ''
      UseKeychain yes
    '';
    extraOptionOverrides = {
      IgnoreUnknown = concatStringsSep "," [
        "UseKeychain"
        "PubkeyAcceptedAlgorithms"
      ];
    };
  };

  # Enable Brew integration
  programs.zsh.initExtra = mkIf pkgs.stdenv.hostPlatform.isDarwin ''
    if which brew > /dev/null; then
      eval "$(brew shellenv)"
    fi
  '';
}
