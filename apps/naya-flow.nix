{ pkgs }:
let
  pname = "NayaFlow";
  version = "0.1.1";
  src = pkgs.fetchurl {
    url = "https://github.com/NayaTech/NayaFlow-releases/releases/download/v${version}/NayaFlow-${version}.AppImage";
    sha256 = "sha256-Fv0EDJaHnBugdNZxAupbphfjseZKeayJtvJfDgo1KPY=";
  };
in
pkgs.appimageTools.wrapType2 { inherit pname version src; }
