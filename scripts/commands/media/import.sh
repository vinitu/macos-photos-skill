#!/usr/bin/env bash
# Output: JSON status envelope.
# Requires: AppleScript backend, jq. Library change (adds photos): needs --yes / PHOTOS_APPROVE_WRITE=1.
# Example:
#   scripts/commands/media/import.sh "/path/to/photo.jpg" "Vacation" --yes
#   {"success":true,"data":{"imported":true,"path":"/path/to/photo.jpg"}}
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
[[ "${#args[@]}" -lt 1 || "${#args[@]}" -gt 2 ]] && usage "$(basename "$0") <path> [album] [--yes]"
path="${args[0]}"
require_arg "$path" "path"
[[ -e "$path" ]] || json_fail "import path not found: ${path}"

if [[ "$approve" -ne 1 ]]; then
  require_write_approval
fi

if [[ "${#args[@]}" -eq 2 ]]; then
  run_backend media import "$path" "${args[1]}" >/dev/null
else
  run_backend media import "$path" >/dev/null
fi
json_ok "$(printf '%s' "$path" | "$JQ_BIN" -R -c '{imported:true,path:.}')"