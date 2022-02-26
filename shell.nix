{ sources ? import nix/sources.nix
, pkgs ? import sources.nixpkgs {}
, kubernix-src ? sources.kubernix
}:

let kubernix = pkgs.kubernix.overrideAttrs (attrs: rec {
      name = "${attrs.pname}-${version}";
      version = "630087e023e403d461c4bb8b1c9368b26a2c0744";

      /*
      src = pkgs.fetchFromGitHub {
        owner = "saschagrunert";
        repo = attrs.pname;
        rev = "${version}";
        sha256 = "1wvfiaxqj5cc5ad7k2xf4cmhmngmhf43gv55zlns8fjnvjjdair2";
      };
      */
      src = ../kubernix;

      cargoDeps = attrs.cargoDeps.overrideAttrs (pkgs.lib.const {
        name = "${name}-vendor.tar.gz";
        inherit src;
        outputHash = "0p8498jl1qj02dikr2cffgcyzsaa7890brc53pg3bngrbv5ipv9w";
      });
    });
in pkgs.mkShell {
  buildInputs = [
    # keep this line if you use bash
    # pkgs.bashInteractive

    kubernix
    (import "${kubernix-src}/nix")

  ];
}
