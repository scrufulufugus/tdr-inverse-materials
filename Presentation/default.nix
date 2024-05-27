{
  stdenvNoCC,
  lib,
  emacs,
  tex,
  inkscape,
  pygments,
  fontConfig ? {},
  ...
}:

stdenvNoCC.mkDerivation {
  pname = "tdr-inverse-presentation";
  version = "0.0.1";

  src = ./.;

  buildInputs = [
    emacs
    tex
    inkscape
    pygments
  ];

  FONTCONFIG_FILE = fontConfig;

  preBuild = ''
    HOME=$PWD
  '';

  buildPhase = ''
    # Fixes `Fontconfig error: no writable cache directories`
    export XDG_CACHE_HOME="$(mktemp -d)"
    # Needed for inkscape
    export XDG_DATA_HOME="$(mktemp -d)"
    export XDG_CONFIG_HOME="$(mktemp -d)"

    emacs -q -nl --script org2tex.el Presentation.org
    latexmk -shell-escape -xelatex Presentation.tex
  '';

  installPhase = ''
    mkdir -p $out
    cp Presentation.pdf $out
  '';

  meta = with lib; {
    name = "tdr-inverse-presentation";
    description = "Tangles and compiles a org-mode file to PDF";
    homepage = "";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
