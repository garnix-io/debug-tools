import * as garn from "https://garn.io/ts/v0.0.14/mod.ts";
import * as pkgs from "https://garn.io/ts/v0.0.14/nixpkgs.ts";

export const main = garn.haskell
  .mkHaskellProject({
    description: "debug-tools",
    executable: "debug-args",
    compiler: "ghc94",
    src: ".",
  })
  .withDevTools([
    pkgs.hlint,
    garn.mkPackage(garn.nix.nixRaw`
      (pkgs.haskell-language-server.override {
        dynamic = true;
        supportedGhcVersions = [ "94" ];
      })
    `),
  ])
  .addCheck("hlint")`hlint *.hs`;
