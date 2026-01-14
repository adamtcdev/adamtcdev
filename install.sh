#!/usr/bin/env bash
set -euo pipefail

PKG=ubuntu-desktop

echo "[*] Updating package lists…"
sudo apt update

echo "[*] Extracting Depends only…"

deps=$(
  apt-cache show "$PKG" \
  | awk '
      /^Depends:/ {
        sub(/^Depends: /, "")
        gsub(",", "\n")
        print
      }
    ' \
  | sed 's/([^)]*)//g' \
  | awk -F'|' '{print $1}' \
  | xargs -n1 \
  | sort -u
)

echo
echo "=== Packages to be installed (Depends only) ==="
echo "$deps"
echo "=============================================="
echo

read -p "Proceed? [y/N] " yn
[[ "$yn" =~ ^[Yy]$ ]] || exit 0

sudo apt install --no-install-recommends -y $deps

echo
echo "[✓] Done. ubuntu-desktop meta-package NOT installed."
