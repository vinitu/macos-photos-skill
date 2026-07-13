.PHONY: dictionary dictionary-photos dictionary-standard compile check test test-dictionary test-smoke

dictionary:
	@printf '### Photos.app\n'
	@sdef /System/Applications/Photos.app
	@printf '\n### CocoaStandard.sdef\n'
	@cat /System/Library/ScriptingDefinitions/CocoaStandard.sdef

dictionary-photos:
	@sdef /System/Applications/Photos.app

dictionary-standard:
	@cat /System/Library/ScriptingDefinitions/CocoaStandard.sdef

compile:
	@set -euo pipefail; \
	find scripts/applescripts -name '*.applescript' -print | while IFS= read -r file; do \
		osacompile -o /tmp/$$(echo "$$file" | tr '/' '_' | sed 's/\.applescript$$/.scpt/') "$$file" || exit 1; \
	done; \
	find tests scripts/commands -name '*.sh' -print | while IFS= read -r file; do \
		bash -n "$$file" || exit 1; \
	done

check:
	@osascript -e 'tell application "Photos" to get name' >/dev/null || { echo "check: Photos not available"; exit 1; }
	@echo "Photos is available"

test: test-dictionary test-smoke

test-dictionary:
	@bash tests/dictionary_contract.sh

test-smoke:
	@bash tests/smoke_photos.sh
