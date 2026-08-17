#!/usr/bin/env bash
# Output: JSON array of media filenames (album or library, optional limit).
# Requires: AppleScript backend, jq.
# Example:
#   scripts/commands/media/list.sh
#   {"success":true,"data":["IMG_0001.jpg","IMG_0002.jpg"]}
#   scripts/commands/media/list.sh "Vacation" 10
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

[[ $# -gt 2 ]] && usage "$(basename "$0") [album|library] [limit]"

args=()
[[ $# -ge 1 ]] && args+=("$1")
[[ $# -ge 2 ]] && args+=("$2")

raw="$(run_backend media list "${args[@]}")"
data="$(printf '%s' "$raw" | lines_to_json)"
json_ok "$data"