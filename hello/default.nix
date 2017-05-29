{ mkDerivation, base, snap-core, snap-server, stdenv }:
mkDerivation {
  pname = "hello";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base snap-core snap-server ];
  license = stdenv.lib.licenses.bsd3;
}
