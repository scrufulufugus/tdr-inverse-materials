{
  description = "Latex Dependencies";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        tex = pkgs.texlive.combined.scheme-full;
        emacsWith = ((pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (
          epkgs: with epkgs; [ use-package org org-ref org-contrib ]
        ));
      in
      {
        packages = rec {
          presentation = pkgs.callPackage ./Presentation {
            tex = tex;
            emacs = emacsWith;
            pygments = pkgs.python311Packages.pygments;
          };
          proposal = pkgs.callPackage ./Proposal { tex = tex; emacs = emacsWith; };
          default = pkgs.buildEnv {
            name = "tdr-inverse-materials";
            paths = [ presentation proposal ];
          };

        };

        devShells.default = pkgs.mkShell.override { stdenv = pkgs.stdenvNoCC; } {
          packages = with pkgs; [ texlive.combined.scheme-full python311Packages.pygments ];
        };
      });
}
