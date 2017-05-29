# Example of using nix with haskell

## Create `default.nix` receipe for our package.

```bash
cd hello
cabal2nix . > default.nix
cd ..
```

## Nix expr for overriden package

Say we want to fix `snap-server` to certain commit

```bash
cabal2nix --revision 5c5b32de4ed653c963ce53e94bec278dba101a7f  http://github.com/snapframework/snap-server.git > pkgs/snap-server.nix
```

## Fix nixpkgs to certain commit

See nixpkgs.nix

```nix
{ overlays }:
let
  nixpkgs = import <nixpkgs> {};
  fixedNixpkgs = nixpkgs.fetchFromGitHub {
         owner = "NixOS";
         repo = "nixpkgs-channels";
         rev = "e33848568d3321c4f042d8352168a8cf006646e6";
         sha256  = "16ggldc58krs6g5sy477ngsk3dyj0fvh67l9lr2b6b62hvvajbd5";
   };
in
  import fixedNixpkgs { inherit overlays; }

```

## Override snap-server in nixpkgs


```nix
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

```



## Use it in our multi-project release.nix

```nix
let
  pkgs = import ./pkgs.nix;

in {
  hello = pkgs.haskellPackages.callPackage ./hello/default.nix {};
}
```

Now we can build our project with our deps

```bash
nix-build ./release.nix -A hello
./result/bin/hello
```

## Make a shell.nix for our haskell project

hello/shell.nix

```nix
let
  rel = import ../release.nix;
in
  rel.hello.env
```

Now we can enter into environment suitable to build our project

```bash

cd hello
nix-shell
cabal configure && cabal build && dist/build/hello/hello

```

## From now on

Add overriden packages to pkgs.nix.

Add more projects sharing deps to release.nix.

Bump nixpkgs.nix from time to time.