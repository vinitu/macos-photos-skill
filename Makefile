.PHONY: dictionary-photos compile check test test-dictionary test-smoke

dictionary-photos:
	@sdef /System/Applications/Photos.app

compile:
	@set -euo pipefail; \
	find scripts -name '*.applescript' -print | while IFS= read -r file; do \
		osacompile -o /tmp/$$(echo "$$file" | tr '/' '_' | sed 's/\.applescript$$/.scpt/') "$$file"; \
	done

check:
	@osascript -e 'tell application "Photos" to get name' >/dev/null || { echo "check: Photos.app not available"; exit 1; }
	@echo "Photos.app is available"

test: test-dictionary test-smoke

test-dictionary:
	@bash tests/dictionary_contract.sh

test-smoke:
	@bash tests/smoke_photos.sh
