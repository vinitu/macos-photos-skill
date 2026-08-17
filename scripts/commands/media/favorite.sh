#!/usr/bin/env bash
# Output: JSON status envelope.
# Requires: AppleScript backend, jq. Library change (metadata): needs --yes / PHOTOS_APPROVE_WRITE=1.
# Example:
#   scripts/commands/media/favorite.sh "MEDIA-ID" true --yes
#   {"success":true,"data":{"favorite":true,"media_id":"MEDIA-ID"}}
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

approve=0
media_id=""
fav=""
args=()
for a in "$@"; do
  case "$a" in
    --yes) approve=1 ;;
    *) args+=("$a") ;;
  esac
done
[[ "${#args[@]}" -eq 2 ]] || usage "$(basename "$0") <media-id> <true|false> [--yes]"
media_id="${args[0]}"
fav="${args[1]}"
require_arg "$media_id" "media-id"
require_arg "$fav" "favorite"
case "$fav" in
  true|false) ;;
  *) json_fail "favorite must be true or false" ;;
esac

if [[ "$approve" -ne 1 ]]; then
  require_write_approval
fi

run_backend media favorite "$media_id" "$fav" >/dev/null
json_ok "$(printf '%s\n%s' "$media_id" "$fav" | "$JQ_BIN" -n -R --arg id "$media_id" --argjson fav "$fav" '{favorite:$fav,media_id:$id}')"