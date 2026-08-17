#!/usr/bin/env bash
# Output: JSON array of matching media filenames.
# Requires: AppleScript backend, jq.
# Example:
#   scripts/commands/media/search.sh filename "IMG_0001"
#   scripts/commands/media/search.sh favorite true
#   scripts/commands/media/search.sh keyword "beach"
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

[[ $# -ne 2 ]] && usage "$(basename "$0") <by> <value>"
by="$1"; value="$2"
require_arg "$by" "by"
require_arg "$value" "value"
case "$by" in
  filename|favorite|keyword) ;;
  *) json_fail "unsupported search by: ${by} (expected filename|favorite|keyword)" ;;
esac

raw="$(run_backend media search "$by" "$value")"
data="$(printf '%s' "$raw" | lines_to_json)"
json_ok "$data"