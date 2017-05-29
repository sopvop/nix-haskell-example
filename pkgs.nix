let
  overlay = pself: pkgs:
    let
      dontCheck = pkgs.haskell.lib.dontCheck;
    in {
      haskellPackages = pkgs.haskell.packages.ghc802.override {
        overrides = self: super: {
          snap-server = dontCheck (self.callPackage ./pkgs/snap-server.nix {} );
        };
      };
    };
in import ./nixpkgs.nix { overlays = [overlay]; }

