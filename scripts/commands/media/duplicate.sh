#!/usr/bin/env bash
# Output: JSON status envelope.
# Requires: AppleScript backend, jq. Library change: needs --yes / PHOTOS_APPROVE_WRITE=1.
# Example:
#   scripts/commands/media/duplicate.sh "MEDIA-ID" --yes
#   {"success":true,"data":{"duplicated":true,"media_id":"MEDIA-ID"}}
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

approve=0
media_id=""
args=()
for a in "$@"; do
  case "$a" in
    --yes) approve=1 ;;
    *) args+=("$a") ;;
  esac
done
[[ "${#args[@]}" -eq 1 ]] || usage "$(basename "$0") <media-id> [--yes]"
media_id="${args[0]}"
require_arg "$media_id" "media-id"

if [[ "$approve" -ne 1 ]]; then
  require_write_approval
fi

run_backend media duplicate "$media_id" >/dev/null
json_ok "$(printf '%s' "$media_id" | "$JQ_BIN" -R -c '{duplicated:true,media_id:.}')"