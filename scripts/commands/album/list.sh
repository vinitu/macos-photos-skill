#!/usr/bin/env bash
# Output: JSON array of album names.
# Requires: AppleScript backend, jq.
# Example:
#   scripts/commands/album/list.sh
#   {"success":true,"data":["Vacation","Family"]}
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

[[ $# -gt 0 ]] && usage "$(basename "$0")"  # no arguments

raw="$(run_backend album list)"
data="$(printf '%s' "$raw" | lines_to_json)"
json_ok "$data"