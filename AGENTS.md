# AGENTS.md

## Public interface and internal backend

- `scripts/commands/` is the only public command surface. Run commands from the repo root with paths like `scripts/commands/<entity>/<action>.sh`.
- `scripts/applescripts/` is the internal backend. Do not call AppleScript files directly from skill instructions.
- Only commands listed in `SKILL.md` are public. Other scripts may exist for internal use or legacy cleanup.

## Goal

Document the Photos.app AppleScript surface accurately and completely for use by AI agents on macOS.

## Repo Layout

- `AGENTS.md`: this file; rules for editing the repo.
- `SKILL.md`: main skill file with all commands, examples, metadata tables, and troubleshooting.
- `README.md`: repo overview, installation, scope, and quick usage.
- `Makefile`: targets `dictionary-photos`, `check`, `compile`, `test` (test-dictionary + test-smoke).
- `scripts/applescripts/album/list.applescript`, `create.applescript`, `delete.applescript`.
- `scripts/applescripts/folder/list.applescript`.
- `scripts/applescripts/media/list.applescript`, `search.applescript`, `get.applescript`, `export.applescript`, `import.applescript`, `favorite.applescript`, `duplicate.applescript`.
- `scripts/applescripts/slideshow/start.applescript`, `stop.applescript`.
- `scripts/applescripts/application/favorites-album.applescript`, `recently-deleted.applescript`.
- `scripts/spotlight.applescript`.
- `tests/dictionary_contract.sh`: contract test against Photos.app scripting dictionary.
- `tests/smoke_photos.sh`: smoke test for script layer (skips when Photos.app not available).
- `.github/workflows/ci-pr.yml`: PR validation, auto-merge, version bump, tag, and release flow.
- `.github/workflows/ci-main.yml`: main-branch validation, patch tag, and release flow.

## Validation

After making changes:
- run `make check` to ensure Photos.app is available;
- run `make test` to run dictionary contract and smoke tests;
- run `make compile` to compile all AppleScript files (syntax check);
- update `SKILL.md` when coverage changes.

## Editing Rules

1. Keep all documentation in simple English.
2. Update `SKILL.md` whenever coverage changes (new commands, removed features, corrected syntax).
3. Verify every `osascript` command against the actual Photos.app AppleScript dictionary before documenting it. Do not guess at property names or command syntax.
4. Keep examples minimal and copy-paste ready. Use `osascript -e '...'` one-liners where possible; use multi-line `osascript -e 'tell application "Photos" ... end tell'` blocks for anything more complex.
5. If a command does not work or is unreliable, document it in the Limitations section rather than presenting it as supported.
6. Do not add features or commands that require third-party tools unless clearly marked as alternatives (e.g., `mdfind` for Spotlight search).
7. When in doubt, prefer accuracy over completeness.
