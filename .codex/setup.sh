#!/usr/bin/env bash
set -euo pipefail

# Codex Cloud: lightweight source-editing and test environment.
# Android APK builds are delegated to the existing GitHub Actions CI.
cd "$(dirname "$0")/.."

echo "Checking development tools..."
for tool in go node python3; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "Missing $tool. Install it in the Codex environment's base image." >&2
    exit 1
  fi
done

# Go 1.21+ will download the repo-required Go 1.25 toolchain automatically.
export GOTOOLCHAIN=auto
go version
node --version
python3 --version

echo "Downloading Go modules and verifying local tooling..."
go mod download
node --check core/cmd/hongguotv/ui/app.js
python3 -m compileall -q tests

echo "Cloud setup completed. For APK builds, use .github/workflows/ci.yml."
