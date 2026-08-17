#!/usr/bin/env bash
# Output: JSON with the Recently Deleted album name.
# Requires: AppleScript backend, jq.
# Example:
#   scripts/commands/application/recently-deleted.sh
#   {"success":true,"data":{"name":"Recently Deleted"}}
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

[[ $# -gt 0 ]] && usage "$(basename "$0")"  # no arguments

raw="$(run_backend application recently-deleted)"
json_ok "$(printf '%s' "$raw" | "$JQ_BIN" -R -c '{name:.}')"