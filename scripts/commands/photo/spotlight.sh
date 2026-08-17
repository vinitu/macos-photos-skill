#!/usr/bin/env bash
# Output: JSON status envelope.
# Requires: AppleScript backend, jq.
# Example:
#   scripts/commands/photo/spotlight.sh "/path/to/photo.jpg"
#   scripts/commands/photo/spotlight.sh "MEDIA-ID"
#   {"success":true,"data":{"shown":true,"target":"MEDIA-ID"}}
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

[[ $# -ne 1 ]] && usage "$(basename "$0") <path|media-id>"
target="$1"
require_arg "$target" "path|media-id"

run_backend photo spotlight "$target" >/dev/null
json_ok "$(printf '%s' "$target" | "$JQ_BIN" -R -c '{shown:true,target:.}')"