#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
TAG=$(python3 -c "import urllib.request, json; print(json.load(urllib.request.urlopen('https://api.github.com/repos/Moulberry/PandoraLauncher/releases/latest'))['tag_name'])")
VERSION="${TAG#v}"
URL="https://github.com/Moulberry/PandoraLauncher/releases/download/${TAG}/PandoraLauncher-Linux-x86_64.AppImage"
HASH=$(nix store prefetch-file --json "$URL" | python3 -c "import json, sys; print(json.load(sys.stdin)['hash'])")
sed -i -E "s/version = \"[^\"]+\";/version = \"${VERSION}\";/" package.nix
sed -i -E "s|hash = \"sha256-[A-Za-z0-9+/=]+\";|hash = \"${HASH}\";|" package.nix
echo "Updated to ${VERSION} ${HASH}"
echo "Rebuild to apply: nix run . or nixos-rebuild with the overlay"
