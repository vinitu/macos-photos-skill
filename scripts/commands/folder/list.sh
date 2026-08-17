#!/usr/bin/env bash
# Output: JSON array of folder (source) names.
# Requires: AppleScript backend, jq.
# Example:
#   scripts/commands/folder/list.sh
#   {"success":true,"data":["iCloud","My Album"]}
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

[[ $# -gt 0 ]] && usage "$(basename "$0")"  # no arguments

raw="$(run_backend folder list)"
data="$(printf '%s' "$raw" | lines_to_json)"
json_ok "$data"