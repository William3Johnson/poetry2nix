let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    overlays = [
      (import ./overlay.nix)
    ];
  };
  tools = pkgs.callPackage ./tools { };

in
pkgs.mkShell {

  NIX_PATH = "nixpkgs=${sources.nixpkgs}";

  buildInputs = [
    tools.env
    tools.py2-astparse
    tools.flamegraph
    tools.release
    pkgs.nixpkgs-fmt
    pkgs.poetry
    pkgs.niv
    pkgs.jq
    pkgs.nix-prefetch-git
    pkgs.nix-eval-jobs
    pkgs.nix-build-uncached
  ];
}
