{ appimageTools, fetchurl, lib }:
let
  pname = "pandora-launcher";
  version = "6.0.0";
  src = fetchurl {
    url = "https://github.com/Moulberry/PandoraLauncher/releases/download/v${version}/PandoraLauncher-Linux-x86_64.AppImage";
    hash = "sha256-JJQp/9uORwyRNvyXJpOlNu7cnAr8zmDwNH60ioXO/6I=";
  };
  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/usr/share/applications/PandoraLauncher-Linux-x86_64.desktop $out/share/applications/pandora-launcher.desktop
    substituteInPlace $out/share/applications/pandora-launcher.desktop \
      --replace 'Exec=PandoraLauncher-Linux-x86_64' 'Exec=pandora-launcher' \
      --replace 'Icon=PandoraLauncher-Linux-x86_64' 'Icon=pandora-launcher' \
      --replace 'Categories=' 'Categories=Game;'
    mkdir -p $out/share/icons
    cp -r ${appimageContents}/usr/share/icons/hicolor $out/share/icons/hicolor
    chmod -R u+w $out/share/icons
    for size in 16x16 32x32 48x48 64x64 128x128 256x256; do
      if [ -f "$out/share/icons/hicolor/$size/apps/PandoraLauncher-Linux-x86_64.png" ]; then
        mv "$out/share/icons/hicolor/$size/apps/PandoraLauncher-Linux-x86_64.png" "$out/share/icons/hicolor/$size/apps/pandora-launcher.png"
      fi
    done
  '';
  meta = {
    description = "Pandora modern Minecraft launcher packaged from the official upstream AppImage";
    longDescription = "Pandora is a modern Minecraft launcher with sandboxing, cross-instance file syncing, mod deduplication, secure credential management, live game logs, Modrinth and CurseForge browsing, and native performance without Electron or Tauri.";
    homepage = "https://github.com/Moulberry/PandoraLauncher";
    downloadPage = "https://github.com/Moulberry/PandoraLauncher/releases/tag/v${version}";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "pandora-launcher";
    maintainers = [ ];
  };
}
