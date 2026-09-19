{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  inherit (inputs.neovim-nightly-overlay.packages.${system}) neovim;

  appName = "neovim-flake";

  aliases = [
    "vim"
  ];

  desktopEntry = false;

  wrapperArgs = [
    "--set"
    "SNACKS_GHOSTTY"
    "true"
  ];

  extraLuaPackages = p: [
    p.jsregexp
    p.magick
    # p.luacheck
  ];

  providers = {
    ruby.enable = false;
    python3.enable = true;
    nodeJs.enable = false;
    perl.enable = false;
  };

  plugins = {
    start = with pkgs.vimPlugins; [
      lz-n
      plenary-nvim
      # -- disable in favor of mini-icons
      # nvim-web-devicons
      gitsigns-nvim
      mini-icons
      mini-pairs
      nvim-lint
      nvim-treesitter.withAllGrammars
      which-key-nvim
      tiny-inline-diagnostic-nvim
      snacks-nvim
      nvim-lspconfig
      # colorschemes
      vim-moonfly-colors
      blink-cmp
      blink-ripgrep-nvim
      zig-vim
    ];

    opt = with pkgs.vimPlugins; [
      bufferline-nvim
      bufdelete-nvim
      codecompanion-nvim
      conform-nvim
      lspkind-nvim
      lualine-nvim
      lazydev-nvim
      oil-nvim
      render-markdown-nvim
    ];

    dev.config = {
      pure = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.unions [
          ./lua
          ./after
        ];
      };

      impure = "~/projects/neovim-flake";
    };
  };

  initLua = ''
    require("config")
    LZN = require("lz.n")
    LZN.register_handler(require("handlers.which-key"))
    LZN.load("plugins")
  '';

  extraBinPath = builtins.attrValues (
    {
      inherit (pkgs)
        # formatters
        alejandra
        deadnix
        statix
        nixfmt
        stylua
        rustfmt
        ruff
        # LPSs
        bash-language-server
        basedpyright
        gopls
        lua-language-server
        marksman
        # nil
        nixd
        rust-analyzer
        vscode-langservers-extracted
        # vtsls
        typescript
        zls
        # cli tools
        ripgrep
        fd
        jq
        tmux
        git
        gh
        lazygit
        # rendering
        mermaid-cli
        ;
    }
    // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux { inherit (pkgs) wl-clipboard; }
  );
}
