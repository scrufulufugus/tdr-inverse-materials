{
  stdenvNoCC,
  lib,
  emacs,
  tex,
  ...
}:

stdenvNoCC.mkDerivation {
  pname = "tdr-inverse-proposal";
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
    # Fixes `Fontconfig error: no writable cache directories`
    export XDG_CACHE_HOME="$(mktemp -d)"
    emacs -q -nl --script org2tex.el Proposal.org
    latexmk -shell-escape -xelatex Proposal.tex
  '';

  installPhase = ''
    mkdir -p $out
    cp Proposal.pdf $out
  '';

  meta = with lib; {
    name = "tdr-inverse-proposal";
    description = "Tangles and compiles a org-mode file to PDF";
    homepage = "";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
