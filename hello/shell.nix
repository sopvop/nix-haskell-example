let
  rel = import ../release.nix;
in
  rel.hello.env
