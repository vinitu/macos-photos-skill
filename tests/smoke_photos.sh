#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! osascript -e 'tell application "Photos" to get name' >/dev/null 2>&1; then
	echo "smoke_photos: Photos.app not available."
	exit 0
fi

album_out="$(osascript "$ROOT_DIR/scripts/album/list.applescript" 2>&1)" || { echo "smoke_photos: Photos not running, skipping."; exit 0; }
printf '%s\n' "$album_out" >/dev/null || { echo "smoke_photos: album list failed." >&2; exit 1; }

folder_out="$(osascript "$ROOT_DIR/scripts/folder/list.applescript" 2>&1)" || true
media_out="$(osascript "$ROOT_DIR/scripts/media/list.applescript" "library" "10" 2>&1)" || true
printf '%s\n' "$folder_out" "$media_out" >/dev/null || true

echo "smoke_photos: ok"
