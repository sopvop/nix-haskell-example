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
