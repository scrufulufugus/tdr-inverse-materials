# Optimized GPU-Based Matrix Inversion Though The Use of Thread-Data Remapping

## PDF Versions

![Proposal - Rendered](https://github.com/scrufulufugus/tdr-inverse-materials/blob/pdf/Proposal.pdf)

![Final Presentation - Rendered](https://github.com/scrufulufugus/tdr-inverse-materials/blob/pdf/Presentation.pdf)

## About <a name="about"></a>

This is a collection of papers and presentation materials done as a masters project. The code that these documents relate to [can be found here](https://github.com/scrufulufugus/tdr-inverse).

## Building <a name="building"></a>

All documents are written with [Emacs Org Mode](https://orgmode.org/), which is compiled to LaTeX, which is compiled to PDFs. This process is automated by nix and deployed on commit to the [pdf](https://github.com/scrufulufugus/tdr-inverse-materials/tree/pdf) branch. The nix packages can be built locally if one wants to:

1. Install nix with flake and nix-command support, you can follow [this guide](https://zero-to-nix.com/start/install):

  ``` sh
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```

2. Clone this repository and enter it:

  ```sh
  git clone https://github.com/scrufulufugus/tdr-inverse-materials.git
  cd tdr-inverse-materials
  ```

3. Build with nix

  ```sh
  nix build -o results
  # Copy the PDFs out of the nix store
  cp -L --no-preserve=all -t ./ ./result/*
  ```
