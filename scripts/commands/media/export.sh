#!/usr/bin/env bash
# Output: JSON status envelope.
# Requires: AppleScript backend, jq. Exports user photos to disk: needs --yes / PHOTOS_APPROVE_WRITE=1.
# Example:
#   scripts/commands/media/export.sh "Vacation" "/tmp/out" --yes
#   scripts/commands/media/export.sh "Vacation" "/tmp/out" --yes using originals
#   {"success":true,"data":{"exported":true,"album":"Vacation","path":"/tmp/out"}}
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

approve=0
args=()
for a in "$@"; do
  case "$a" in
    --yes) approve=1 ;;
    *) args+=("$a") ;;
  esac
done
[[ "${#args[@]}" -lt 2 ]] && usage "$(basename "$0") <album> <output-path> [using originals] [--yes]"
album="${args[0]}"
out_path="${args[1]}"
require_arg "$album" "album"
require_arg "$out_path" "output-path"
[[ -d "$out_path" ]] || json_fail "output path is not a directory: ${out_path}"

if [[ "$approve" -ne 1 ]]; then
  require_write_approval
fi

if [[ "${#args[@]}" -ge 3 && "${args[2]}" == "using originals" ]]; then
  run_backend media export "$album" "$out_path" "using originals" >/dev/null
else
  run_backend media export "$album" "$out_path" >/dev/null
fi
json_ok "$(printf '%s\n%s' "$album" "$out_path" | "$JQ_BIN" -n --arg album "$album" --arg path "$out_path" '{exported:true,album:$album,path:$path}')"