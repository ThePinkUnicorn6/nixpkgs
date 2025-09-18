{
  lib,
  stdenv,
  fetchFromGitLab,
  libsForQt5,
  openrgb,
  glib,
  pkg-config,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "openrgb-plugin-visual-map";
  version = "0.9";

  src = fetchFromGitLab {
    owner = "OpenRGBDevelopers";
    repo = "OpenRGBVisualMapPlugin";
    rev = "release_${finalAttrs.version}";
    hash = "sha256-8w5f/aZcnWKht8Af2S9ekD/cXyi7Nlklf85YMAHU3+M=";
  };

  postPatch = ''
    # Use the source of openrgb from nixpkgs instead of the submodule
    rm -r OpenRGB
    ln -s ${openrgb.src} OpenRGB
  '';
  
  nativeBuildInputs = with libsForQt5; [
    qmake
    pkg-config
    wrapQtAppsHook
  ];
  
  buildInputs = with libsForQt5; [
    qtbase
    glib
  ];
  
  meta = with lib; {
    homepage = "https://gitlab.com/OpenRGBDevelopers/OpenRGBVisualMapPlugin";
    description = "OpenRGB plugin for grouping and organizing devices on a spatial map";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ ThePinkUnicorn ];
    platforms = platforms.linux;
  };
})
