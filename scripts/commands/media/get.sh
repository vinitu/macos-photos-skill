#!/usr/bin/env bash
# Output: JSON object of media item metadata.
# Requires: AppleScript backend, jq.
# Example:
#   scripts/commands/media/get.sh 1
#   scripts/commands/media/get.sh "Vacation" 1
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

[[ $# -lt 1 || $# -gt 2 ]] && usage "$(basename "$0") <index> [album]"
if [[ $# -eq 1 ]]; then
  index="$1"
  require_arg "$index" "index"
  raw="$(run_backend media get "$index")"
else
  album="$1"; index="$2"
  require_arg "$album" "album"
  require_arg "$index" "index"
  raw="$(run_backend media get "$album" "$index")"
fi

data="$(printf '%s' "$raw" | kv_to_json)"
json_ok "$data"