{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        debug-tools = pkgs.haskellPackages.callCabal2nix "debug-tools" ./. { };
      in
      {
        packages.default = debug-tools;

        checks.hpack-up-to-date = pkgs.runCommand "hpack-up-to-date"
          {
            nativeBuildInputs = [ pkgs.haskellPackages.hpack pkgs.diffutils ];
          } ''
          cp ${./package.yaml} package.yaml
          cp ${./debug-tools.cabal} debug-tools.cabal.orig
          hpack
          diff -u debug-tools.cabal.orig debug-tools.cabal \
            || (echo "error: debug-tools.cabal is out of date, run hpack" && exit 1)
          touch $out
        '';

        devShells.default = pkgs.mkShell {
          inputsFrom = [ debug-tools ];
          packages = [
            pkgs.haskellPackages.cabal-install
            pkgs.haskellPackages.hpack
            pkgs.haskellPackages.haskell-language-server
          ];
        };
      });
}
