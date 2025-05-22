{
  stdenv,
  appimage-run,
  makeWrapper,
  copyDesktopItems,
  makeDesktopItem,
  fetchurl,
}:
stdenv.mkDerivation {
  name = "zen";
  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/1.12.7b/zen-x86_64.AppImage";
    sha256 = "14c2pjnap39p0kr4z556bq7x5yhgpjpb0ckxf78s805cnlfwbzbh";
  };
  dontUnpack = true;
  nativeBuildInputs = [
    appimage-run
    makeWrapper
    copyDesktopItems
  ];
  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/applications
    cp $src $out/share/applications/zen-browser.AppImage
    chmod +x $out/share/applications/zen-browser.AppImage
    makeWrapper ${appimage-run}/bin/appimage-run $out/bin/zen --add-flags "$out/share/applications/zen-browser.AppImage"

    runHook postInstall
  '';
  desktopItems = [
    (makeDesktopItem {
      name = "Zen";
      desktopName = "Zen";
      comment = "Experience tranquillity while browsing the web without people tracking you!";
      exec = "zen %u";
      icon = "zen";
      mimeTypes = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "application/x-xpinstall"
        "application/pdf"
        "application/json"
      ];
      startupWMClass = "zen";
      categories = [
        "Network"
        "WebBrowser"
      ];
      startupNotify = true;
      terminal = false;
      extraConfig = {
        "X-MultipleArgs" = "false";
      };
      keywords = [
        "Internet"
        "WWW"
        "Browser"
        "Web"
        "Explorer"
      ];
      actions = {
        "new-window" = {
          name = "Open a New Window";
          exec = "zen %u";
        };
        "new-private-window" = {
          name = "Open a New Private Window";
          exec = "zen --private-window %u";
        };
        "profilemanager" = {
          name = "Open the Profile Manager";
          exec = "zen --ProfileManager %u";
        };
      };
    })
  ];
}
