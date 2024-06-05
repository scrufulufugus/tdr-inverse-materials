{
  stdenvNoCC,
  lib,
  emacs,
  tex,
  pygments,
  fontConfig ? {},
  ...
}:

stdenvNoCC.mkDerivation {
  pname = "tdr-inverse-paper";
  version = "0.0.1";

  src = ./.;

  buildInputs = [
    emacs
    tex
    pygments
  ];

  FONTCONFIG_FILE = fontConfig;

  preBuild = ''
    HOME=$PWD
  '';

  buildPhase = ''
    # Fixes `Fontconfig error: no writable cache directories`
    export XDG_CACHE_HOME="$(mktemp -d)"

    emacs -q -nl --script org2tex.el Paper.org
    latexmk -shell-escape -xelatex Paper.tex
  '';

  installPhase = ''
    mkdir -p $out
    cp Paper.pdf $out
  '';

  meta = with lib; {
    name = "tdr-inverse-paper";
    description = "Tangles and compiles a org-mode file to PDF";
    homepage = "";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
