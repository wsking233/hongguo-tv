# Codex Cloud development notes

This fork inherits the upstream multi-platform hongguo-tv project. Keep contributions compatible with the upstream architecture.

## Setup

In Codex Cloud, create an environment for `wsking233/hongguo-tv`, select the standard Linux environment, and use this setup command:

```bash
bash .codex/setup.sh
```

The script prepares Go dependencies and checks Node.js/Python. It intentionally does **not** install Android SDK, NDK or Gradle: the repository already provides these in GitHub Actions (`.github/workflows/ci.yml`). The base environment must have Go 1.21+ (automatic Go 1.25 toolchain selection), Node.js and Python 3. If Go is absent, select a Codex image with Go installed first.

## Cloud validation

```bash
go test ./...
python3 -m unittest discover -s tests -p 'test_*.py'
node --test tests/*.test.cjs
```

Run the JavaScript syntax checks defined by `.github/workflows/ci.yml` when changing the WebView UI. Run `git diff --check` before committing.

## APK builds and device testing

Use GitHub Actions CI for standard and MPV APK compilation and lint. The existing CI does not upload APK artifacts on every branch; a separate workflow change may be required for convenient manual APK downloads. Device-specific tests (remote focus, playback, decoding, ADB logcat) require a real TV or suitable local device and cannot be verified solely by Codex Cloud.

## Contribution hygiene

Make small scoped changes on feature branches. Do not change release signing, publish workflows or secrets. Preserve upstream Go module path (`github.com/aston314/hongguo-tv`) unless there is a compelling technical reason and an agreed migration. Avoid checking in binaries or generated APK files. Describe what has and has not been verified in pull requests.
