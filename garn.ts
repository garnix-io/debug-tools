import * as garn from "https://garn.io/ts/v0.0.14/mod.ts";
import { nixRaw } from "https://garn.io/ts/v0.0.14/nix.ts";

export const main = garn.haskell
  .mkHaskellProject({
    description: "debug-tools",
    executable: "debug-args",
    compiler: "ghc94",
    src: ".",
  })
  .withDevTools([
    garn.mkPackage(nixRaw`
      (pkgs.haskell-language-server.override {
        dynamic = true;
        supportedGhcVersions = [ "94" ];
      })
    `),
  ]);
