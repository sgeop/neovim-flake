{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mnw.url = "github:gerg-l/mnw";
    systems.url = "github:nix-systems/default";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # plugins
    blink-cmp.url = "github:saghen/blink.cmp";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      mnw,
      systems,
      blink-cmp,
      ...
    }:
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

      formatter = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.writeShellApplication {
          name = "format";
          runtimeInputs = builtins.attrValues {
            inherit (pkgs)
              nixfmt-rfc-style
              deadnix
              statix
              fd
              stylua
              ;
          };
          text = ''
            fd "$@" -t f -e nix -x statix fix -- '{}'
            fd "$@" -t f -e nix -X deadnix -e -- '{}' \; -X nixfmt '{}'
            fd "$@" -t f -e lua -X stylua --indent-type Spaces --indent-width 2 '{}'
          '';
        }
      );

      devShells = eachSystem (
        system:
        let
          pkgs = import nixpkgs { inherit system; }; # nixpkgs.legacyPackages.${system};
          shell = pkgs.mkShell {
            name = "nvim-shell";
            buildInputs = [
              pkgs.lua-language-server
              pkgs.luaPackages.luacheck
              self.packages.${system}.default.devMode
            ];
          };
        in
        {
          default = shell;
          # packages = nixpkgs.lib.singleton self.packages.${pkgs.stdenv.hostPlatform.system}.default.devMode;
        }
      );

      packages = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = self.packages.${system}.neovim;

          dev = self.packages.${system}.default.devMode;

          inherit (self.packages.${system}.default) configDir;

          neovim = mnw.lib.wrap { inherit pkgs inputs; } ./config.nix;
        }
      );
    };
}
