{ pkgs }:
let
  owner = "elixir-lang";
  pname = "expert";
  version = "nightly";
  arch = "linux_amd64";
  src = pkgs.fetchurl {
    url = "https://github.com/${owner}/${pname}/releases/download/${version}/${pname}_${arch}";
    sha256 = "08dxlnzsfpsv0jgz5c9g8r9ifh3mp109ais0wkp75iw4wl8g5xnm";
  };
in
pkgs.stdenv.mkDerivation {
  pname = pname;
  version = version;
  src = src;
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    cp ${src} $out/bin/${pname}
    chmod +x $out/bin/${pname}
  '';
}
