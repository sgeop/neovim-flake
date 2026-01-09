{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  blink-packages = inputs.blink-cmp.packages.${system};
in
{
  inherit (inputs.neovim-nightly-overlay.packages.${system}) neovim;

  appName = "neovim-flake";

  aliases = [
    "nn"
    "mnw"
  ];

  desktopEntry = false;

  extraLuaPackages = p: [
    p.jsregexp
    p.magick
    p.luacheck
  ];

  providers = {
    ruby.enable = false;
    python3.enable = true;
    nodeJs.enable = true;
    perl.enable = false;
  };

  plugins = {
    start =
      with pkgs.vimPlugins;
      [
        lz-n
        plenary-nvim
        # -- disable in favor of mini-icons
        # nvim-web-devicons
        mini-icons
        nvim-lint
        which-key-nvim
        snacks-nvim
        # colorschemes
        vim-moonfly-colors
      ]
      ++ [
        nvim-treesitter.withAllGrammars.dependencies
      ];

    opt = with pkgs.vimPlugins; [
      # inputs.blink-cmp.packages.${pkgs.stdenv.system}.blink-cmp
      # inputs.blink-cmp.packages.${pkgs.stdenv.system}.blink-fuzzy-plugin
      blink-packages.blink-cmp
      blink-ripgrep-nvim
      bufferline-nvim
      bufdelete-nvim
      conform-nvim
      lspkind-nvim
      lualine-nvim
      lazydev-nvim
      nvim-lspconfig
      nvim-treesitter
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
        alejandra
        deadnix
        statix
        nixfmt-rfc-style
        stylua
        rustfmt
        shellcheck
        gofumpt
        golangci-lint
        yamlfmt
        jsonfmt
        # langservers
        lua-language-server
        nil
        rust-analyzer
        vscode-langservers-extracted
        zls
        ruff
        # cli tools
        ripgrep
        fd
        jq
        yq
        tmux
        git
        gh
        lazygit
        ;
    }
    // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux { inherit (pkgs) wl-clipboard; }
  );
}
