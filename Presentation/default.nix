{
  stdenvNoCC,
  lib,
  emacs,
  tex,
  ...
}:

stdenvNoCC.mkDerivation {
  pname = "tdr-inverse-presentation";
  version = "0.0.1";

  src = ./.;

  buildInputs = [
    emacs
    tex
  ];

  preBuild = ''
    HOME=$PWD
  '';

  buildPhase = ''
    emacs -q -nl --script org2tex.el Presentation.org
    latexmk -xelatex Presentation.tex
  '';

  installPhase = ''
    echo $HOME
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
