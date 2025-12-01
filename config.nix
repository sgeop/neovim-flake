{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  inherit (inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.system}) neovim;

  appName = "mnw";

  desktopEntry = false;

  extraLuaPackages = p: [
    p.jsregexp
    p.magick
    p.luacheck
  ];

  providers = {
    ruby.enable = true;
    python3.enable = true;
    nodeJs.enable = true;
    perl.enable = true;
  };

  plugins.start = with pkgs.vimPlugins; [
    lz-n
    plenary-nvim
    nvim-web-devicons
    nvim-treesitter.withAllGrammars
    which-key-nvim
    snacks-nvim
  ];

  plugins.opt = with pkgs.vimPlugins; [
    blink-cmp
    bufferline-nvim
    bufdelete-nvim
    conform-nvim
    lspkind-nvim
    lualine-nvim
    lazydev-nvim
    nvim-lspconfig
    oil-nvim
  ];

  plugins.dev.config = {
    pure = lib.fileset.toSource {
      root = ./.;
      fileset = lib.fileset.unions [
        ./lua
        ./after
      ];
    };

    impure = "~/projects/neovim-flake";
  };

  initLua = ''
    		require("config")
    		LZN = require("lz.n")
        LZN.register_handler(require("handlers.which-key"))
    		LZN.load("plugins")
    	'';

  extraBinPath =
    let
      formatters = with pkgs; [
        nixfmt-rfc-style
        stylua
        deadnix
        statix
        rustfmt
      ];

      langservers = with pkgs; [
        lua-language-server
        nil
        rust-analyzer
        vscode-langservers-extracted
      ];
      misc =
        with pkgs;
        [
          fd
          jq
          tmux
          git
          gh
          lazygit
          ripgrep
          imagemagickBig
          ueberzugpp
          tectonic
          mermaid-cli
        ]
        ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.wl-clipboard ];
    in
    lib.unique (formatters ++ langservers ++ misc);

  # extraBinPath = builtins.attrValues {
  #   inherit (pkgs)
  # 	  deadnix
  # 		statix
  # 		nixfmt-rfc-style
  # 		stylua
  # 		rustfmt

  # 		lua-language-server
  # 		nil
  # 		rust-analyzer

  # 		ripgrep
  # 		fd
  # 		vscode-langservers-extracted
  # 		;
  # };
}
