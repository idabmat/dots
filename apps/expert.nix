{ pkgs }:
let
  owner = "elixir-lang";
  pname = "expert";
  version = "nightly";
  arch = "linux_amd64";
  src = pkgs.fetchurl {
    url = "https://github.com/${owner}/${pname}/releases/download/v${version}/${pname}_${arch}";
    sha256 = "1ihv6z1l8g825k32rf553zzzqkyjqcngf86j0785i0380x1vz8pf";
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
