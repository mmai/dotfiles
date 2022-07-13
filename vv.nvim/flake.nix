{
  description = "Neovim Configuration inspired by Neovim From Scratch and Nyoovim";

  # inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

  outputs =
    { self
    , nixpkgs
    , flake-utils
    # , neovim-nightly-overlay
    }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "vv.nvim";
      # preOverlays = [ neovim-nightly-overlay.overlay ];
      shell = { pkgs }:
        pkgs.mkShell {
          # https://nix.dev/anti-patterns/language#with-attrset-expression
          packages = builtins.attrValues {
            inherit
              (pkgs)
              neovim
              # neovim-nightly
              ripgrep
              # fennel
              # fnlfmt
              ;
          };

          shellHook = ''
            alias nvim="nvim -u $(pwd)/init.lua" --cmd "set rtp+=$(pwd)"
          '';
        };
    };
}
