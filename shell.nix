{ sources ? import nix/sources.nix
, pkgs ? import sources.nixpkgs {}
, kubernix ? import "${sources.kubernix}/nix"
}:

pkgs.mkShell {
  buildInputs = [
    # keep this line if you use bash
    pkgs.bashInteractive

    kubernix
  ];
}
