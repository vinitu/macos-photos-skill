#!/usr/bin/env bash
# Shared helpers for Photos skill command wrappers.
# Sourced by scripts/commands/<entity>/<action>.sh; not a public entrypoint.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
JQ_BIN="${JQ_BIN:-}"

if [[ -z "$JQ_BIN" ]]; then
  if JQ_BIN="$(command -v jq 2>/dev/null)"; then
    :
  elif [[ -x /opt/homebrew/bin/jq ]]; then
    JQ_BIN="/opt/homebrew/bin/jq"
  else
    JQ_BIN=""
  fi
fi

# Print a human usage line to stderr and exit non-zero (not JSON).
usage() {
  local msg="$1"
  printf 'Usage: %s\n' "$msg" >&2
  exit 2
}

# Emit a JSON failure envelope on stdout and exit 1.
json_fail() {
  local msg="$1"
  printf '{"success":false,"error":"%s"}\n' "$msg"
  exit 1
}

# Emit a JSON success envelope on stdout.
# json_ok [payload] -> {"success":true,"data":<payload>}  (payload defaults to {})
json_ok() {
  local payload="${1:-{}}"
  printf '{"success":true,"data":%s}\n' "$payload"
}

# Abort if a required argument value is empty.
require_arg() {
  local v="${1:-}" l="$2"
  [[ -z "$v" ]] && json_fail "missing ${l}"
}

# Abort if jq is not available.
require_jq() {
  [[ -n "$JQ_BIN" ]] || json_fail "jq required"
}

# Resolve the path of an internal AppleScript backend.
backend_script() {
  local e="$1" a="$2"
  printf '%s/scripts/applescripts/%s/%s.applescript' "$ROOT_DIR" "$e" "$a"
}

# Run an AppleScript backend, capture stdout, and on failure emit json_fail.
# Raw backend stdout is printed to stdout for the caller to transform.
run_backend() {
  local e="$1" a="$2"; shift 2
  local sp out rc
  sp="$(backend_script "$e" "$a")"
  [[ -f "$sp" ]] || json_fail "backend script not found: ${sp}"
  set +e
  out=$(/usr/bin/osascript "$sp" "$@" 2>/tmp/photos_osascript_err)
  rc=$?
  set -e
  if [[ "$rc" -ne 0 ]]; then
    local err
    err="$(cat /tmp/photos_osascript_err 2>/dev/null || true)"
    json_fail "backend failed: ${e}/${a}: ${err}"
  fi
  printf '%s' "$out"
}

# Read stdin (raw backend output) and wrap as a JSON string envelope.
# {"success":true,"data":{"message":"<raw>"}}
json_wrap() {
  require_jq
  "$JQ_BIN" -R -c '{success:true,data:{message:.}}'
}

# Read stdin (linefeed-separated values) and emit a JSON array of non-empty strings.
lines_to_json() {
  require_jq
  "$JQ_BIN" -R -s 'split("\n") | map(select(length > 0))'
}

# Read stdin ("key: value" lines) and emit a JSON object.
# Special-cases "dimensions: WxH" into width/height integers.
kv_to_json() {
  require_jq
  "$JQ_BIN" -R -s '
    split("\n")
    | map(select(length > 0))
    | map(split(": "))
    | map({(.[0]): (.[1:] | join(": "))})
    | add // {}
    | if has("dimensions") and (.dimensions | test("^[0-9]+x[0-9]+$")) then
        . + {
          width: ((.dimensions | split("x") | .[0]) | tonumber),
          height: ((.dimensions | split("x") | .[1]) | tonumber)
        }
      else . end
  '
}

# Guardrail for library-mutating commands. Requires explicit approval via:
#   - a --yes flag (wrappers strip it before calling the backend), or
#   - PHOTOS_APPROVE_WRITE=1 in the environment.
# Emits json_fail when approval is missing.
require_write_approval() {
  if [[ "${PHOTOS_APPROVE_WRITE:-0}" != "1" ]]; then
    json_fail "library change requires approval: pass --yes or set PHOTOS_APPROVE_WRITE=1"
  fi
}

# Guardrail for test artifacts. When CODEXTEST=1, require a CodexTest_ prefix so
# test albums/photos are easy to identify and clean up.
require_codextest_prefix() {
  local name="$1" label="$2"
  if [[ "${CODEXTEST:-0}" == "1" && "${name#"CodexTest_"}" == "$name" ]]; then
    json_fail "${label} must be prefixed with CodexTest_ when CODEXTEST=1"
  fi
}