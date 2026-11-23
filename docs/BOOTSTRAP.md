# Fewer bundled packages (lean bootstrap)

By default `termux-app` downloads the official bootstrap during the build.
To ship a smaller one:

1. Clone `termux/termux-packages`.
2. Edit the package list in `scripts/generate-bootstraps.sh`.
3. Run it for `aarch64` and `arm` (add `x86_64` / `i686` for emulators).
4. Host the generated `bootstrap-*.zip` files and point the `downloadBootstraps`
   task in `app/build.gradle` to them (update the SHA-256 checksums).

Never remove: `apt`, `dpkg`, `bash`, `coreutils`, `termux-tools`, `termux-exec`,
`libc++`, `openssl` and their dependencies, or the terminal will not start.
