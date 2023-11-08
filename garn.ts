import * as garn from "https://garn.io/ts/v0.0.15/mod.ts";
import * as pkgs from "https://garn.io/ts/v0.0.15/nixpkgs.ts";

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
  .addCheck("hlint", "hlint *.hs");

export const debugArgs = garn.shell`${main.pkg}/bin/debug-args`;
export const debugSignals = garn.shell`${main.pkg}/bin/debug-signals`;
export const debugTtys = garn.shell`${main.pkg}/bin/debug-ttys`;
