{ compiler ? "ghc844", pkgs ? import <nixpkgs> {} }:

let

  haskellPackages = pkgs.haskell.packages.${compiler};
  drv = haskellPackages.callCabal2nix "aoc2018" ./. {};

  aoc-ghcid = pkgs.writeScriptBin "aoc-ghcid" ''
    #!${pkgs.stdenv.shell}
    ${haskellPackages.ghcid}/bin/ghcid -c "${haskellPackages.cabal-install}/bin/cabal new-repl"
  '';

in
  {
    aoc = drv;
    aoc-shell = haskellPackages.shellFor {
      packages = p: [drv];
      buildInputs = with pkgs; [ cabal-install aoc-ghcid hlint ];
    };
  }
