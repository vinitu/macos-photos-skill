#!/usr/bin/env bash
# Output: JSON with the Favorites album name.
# Requires: AppleScript backend, jq.
# Example:
#   scripts/commands/application/favorites-album.sh
#   {"success":true,"data":{"name":"Favorites"}}
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

[[ $# -gt 0 ]] && usage "$(basename "$0")"  # no arguments

raw="$(run_backend application favorites-album)"
json_ok "$(printf '%s' "$raw" | "$JQ_BIN" -R -c '{name:.}')"