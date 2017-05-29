let
  pkgs = import ./pkgs.nix;

in {
  hello = pkgs.haskellPackages.callPackage ./hello/default.nix {};
}
