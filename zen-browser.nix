{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "zen-browser";
  src = pkgs.fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/1.12.3b/zen-x86_64.AppImage";
    sha256 = "1khajga2r8ndqd3rg8gypr0c58hhzbz7ajnif9q5h20zi2wjfbli";
  };
  buildInputs = with pkgs; [
    appimage-run
    makeWrapper
  ];
  buildCommand = ''
    mkdir -p $out/bin $out/share/applications
    cp $src $out/share/applications/zen-browser.AppImage
    chmod +x $out/share/applications/zen-browser.AppImage
    makeWrapper ${pkgs.appimage-run}/bin/appimage-run $out/bin/zen-browser --add-flags "$out/share/applications/zen-browser.AppImage"
  '';
}
