# debug-tools

A collection of small utilities for debugging process environments.

## Tools

- **debug-args** -- Prints its command-line arguments to stderr.
- **debug-signals** -- Installs handlers for all signals and logs any received signals to stderr.
- **debug-stdin** -- Reads from stdin and logs received data to stderr. Reports when stdin is closed.
- **debug-ttys** -- Reports whether stdin, stdout and stderr are connected to a tty.

You can install `debug-tools` with `cabal` or alternatively with `nix`.
