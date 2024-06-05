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
        fontConfig = pkgs.makeFontsConf { fontDirectories = [ pkgs.hack-font tex.fonts ]; };
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
            fontConfig = fontConfig;
          };
          proposal = pkgs.callPackage ./Proposal { tex = tex; emacs = emacsWith; };
          paper = pkgs.callPackage ./Paper {
            tex = tex;
            emacs = emacsWith;
            pygments = pkgs.python311Packages.pygments;
            fontConfig = fontConfig;
          };
          default = pkgs.buildEnv {
            name = "tdr-inverse-materials";
            paths = [ presentation proposal paper ];
          };

        };

        devShells.default = pkgs.mkShell.override { stdenv = pkgs.stdenvNoCC; } {
          inputsFrom = [
            self.packages.${system}.presentation
            self.packages.${system}.proposal
            self.packages.${system}.paper
          ];
          FONTCONFIG_FILE = fontConfig;
        };
      });
}
