{ pkgs }:
let
  owner = "elixir-lang";
  pname = "expert";
  version = "nightly";
  arch = "linux_amd64";
  src = pkgs.fetchurl {
    url = "https://github.com/${owner}/${pname}/releases/download/v${version}/${pname}_${arch}";
    sha256 = "0clpbf7w1s7gqy2sxmwzhy70x72x2vbsns39k4kzyway6i00p32z";
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
