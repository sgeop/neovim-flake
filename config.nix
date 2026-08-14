{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  packages = {
    inherit (inputs.neovim-nightly-overlay.packages.${system}) neovim;
    inherit (inputs.blink-pairs.packages.${system}) blink-pairs;
  };

  md-render-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "md-render.nvim";
    version = "2026-08-11"; # Tracked revision timestamp
    src = pkgs.fetchFromGitHub {
      owner = "delphinus";
      repo = "md-render.nvim";
      rev = "main"; # Or lock this to a specific SHA for absolute predictability
      hash = "sha256-A3J2ZquRp4ZHmajihR62LDg8viY8DsdAanDXjbLIgHk="; # Run nix-prefetch-url to find your hash
    };
  };
in
{
  inherit (packages) neovim;

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
    nodeJs.enable = true;
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
      packages.blink-pairs
      # minuet-ai-nvim
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
      md-render-nvim
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
        typescript-go
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
