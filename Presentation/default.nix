{
  stdenvNoCC,
  lib,
  emacs,
  emacsPackagesFor,
  texlive,
  ...
}:

let
  emacsFull = ((emacsPackagesFor emacs).emacsWithPackages (
      epkgs: with epkgs; [ use-package org org-ref ]
    ));
in
stdenvNoCC.mkDerivation {
  pname = "tdr-inverse-presentation";
  version = "0.0.1";

  src = ./.;

  buildInputs = [
    emacsFull
    texlive.combined.scheme-full
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
