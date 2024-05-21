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
      in
      {

        devShells.default = pkgs.mkShell.override { stdenv = pkgs.stdenvNoCC; } {
          packages = with pkgs; [ texlive.combined.scheme-full ];
        };
      });
}
