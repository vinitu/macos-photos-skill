#!/usr/bin/env bash
# Output: JSON status envelope.
# Requires: AppleScript backend, jq. Library change: needs --yes / PHOTOS_APPROVE_WRITE=1.
# Example:
#   scripts/commands/album/create.sh "Vacation" --yes
#   {"success":true,"data":{"created":true,"name":"Vacation"}}
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

approve=0
album_name=""
args=()
for a in "$@"; do
  case "$a" in
    --yes) approve=1 ;;
    *) args+=("$a") ;;
  esac
done
[[ "${#args[@]}" -eq 1 ]] || usage "$(basename "$0") <album-name> [--yes]"
album_name="${args[0]}"
require_arg "$album_name" "album-name"
require_codextest_prefix "$album_name" "album-name"

if [[ "$approve" -ne 1 ]]; then
  require_write_approval
fi

run_backend album create "$album_name" >/dev/null
json_ok "$(printf '%s' "$album_name" | "$JQ_BIN" -R -c '{created:true,name:.}')"