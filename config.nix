{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  inherit (inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.system}) neovim;

  appName = "neovim-flake";

  aliases = [
    "vim"
  ];

  desktopEntry = false;

  extraLuaPackages = p: [
    p.jsregexp
    p.magick
    # p.luacheck
  ];

  providers = {
    ruby.enable = true;
    python3.enable = true;
    nodeJs.enable = true;
    perl.enable = true;
  };

  plugins = {
    start = with pkgs.vimPlugins; [
      lz-n
      plenary-nvim
      # -- disable in favor of mini-icons
      # nvim-web-devicons
      mini-icons
      nvim-lint
      nvim-treesitter.withAllGrammars
      which-key-nvim
      snacks-nvim
      # colorschemes
      vim-moonfly-colors
    ];

    opt = with pkgs.vimPlugins; [
      blink-cmp
      blink-ripgrep-nvim
      bufferline-nvim
      bufdelete-nvim
      conform-nvim
      lspkind-nvim
      lualine-nvim
      lazydev-nvim
      nvim-lspconfig
      oil-nvim
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

  # extraBinPath = with pkgs;
  #   let
  #     formatters = [
  #       nixfmt-rfc-style
  #       stylua
  #       deadnix
  #       statix
  #       rustfmt
  #       luaPackages.luacheck
  #     ];

  #     langservers = [
  #       lua-language-server
  #       nil
  #       rust-analyzer
  #       vscode-langservers-extracted
  #       zls
  #       rust-analyzer
  #     ];
  #     misc = [
  #       fd
  #       jq
  #       tmux
  #       git
  #       gh
  #       lazygit
  #       ripgrep
  #       imagemagickBig
  #       ueberzugpp
  #       tectonic
  #       mermaid-cli
  #     ]
  #     ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.wl-clipboard ];
  #   in
  #   lib.unique (formatters ++ langservers ++ misc);

  extraBinPath = builtins.attrValues (
    {
      inherit (pkgs)
        # formatters
        deadnix
        statix
        nixfmt-rfc-style
        stylua
        rustfmt

        # langservers
        lua-language-server
        # nil
        nixd
        rust-analyzer
        vscode-langservers-extracted
        zls

        # cli tools
        ripgrep
        fd
        jq
        tmux
        git
        gh
        lazygit
        ;
    }
    // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux { inherit (pkgs) wl-clipboard; }
  );
}
