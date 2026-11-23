# Building & Releasing

## Local build

Requirements: JDK 17, Android SDK, and the NDK version in `gradle.properties`.

```bash
TERMUX_SPLIT_APKS_FOR_RELEASE_BUILDS=1 ./gradlew assembleRelease
```

Output: `app/build/outputs/apk/release/LinTerm_*_{arm64-v8a,armeabi-v7a}.apk`.
Without signing credentials the APK is produced **unsigned** (suitable for CI checks only).

## Signing

Release builds are signed with a private keystore supplied through environment variables
(`KEYSTORE_PATH`, `KEYSTORE_PASSWORD`, `KEY_ALIAS`, `KEY_PASSWORD`).

Generate one with:

```bash
bash scripts/make-keystore.sh
```

The script prints the four values to store as GitHub Actions secrets
(`KEYSTORE_BASE64`, `KEYSTORE_PASSWORD`, `KEY_ALIAS`, `KEY_PASSWORD`).

> Back up `lin.jks` and its password outside the repository. A lost keystore means
> existing users cannot upgrade. Never commit it.

## Releasing

Push a version tag, or run **Actions → Release → Run workflow**:

```bash
git tag v1.0.0 && git push origin v1.0.0
```

The workflow builds signed APKs for `arm64-v8a` and `armeabi-v7a`, generates
`SHA256SUMS.txt`, and publishes a GitHub Release.

## Lean bootstrap

See [`BOOTSTRAP.md`](BOOTSTRAP.md).
