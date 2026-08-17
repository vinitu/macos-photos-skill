#!/usr/bin/env bash
# Output: JSON status envelope.
# Requires: AppleScript backend, jq.
# Example:
#   scripts/commands/slideshow/stop.sh
#   {"success":true,"data":{"stopped":true}}
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../_lib/common.sh"
require_jq

[[ $# -gt 0 ]] && usage "$(basename "$0")"  # no arguments

run_backend slideshow stop >/dev/null
json_ok '{"stopped":true}'