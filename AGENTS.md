# AGENTS.md

## Goal

Document the Photos.app AppleScript surface accurately and completely for use by AI agents on macOS.

## Repo Layout

```
macos-photos-skill/
  SKILL.md    — main skill file with all commands, examples, metadata tables, and troubleshooting
  README.md   — repo overview, installation, scope, and quick usage
  LICENSE     — MIT license
  AGENTS.md   — this file: guidelines for editing the repo
```

## Editing Rules

1. Keep all documentation in simple English.
2. Update `SKILL.md` whenever coverage changes (new commands, removed features, corrected syntax).
3. Verify every `osascript` command against the actual Photos.app AppleScript dictionary before documenting it. Do not guess at property names or command syntax.
4. Keep examples minimal and copy-paste ready. Use `osascript -e '...'` one-liners where possible; use multi-line `osascript -e 'tell application "Photos" ... end tell'` blocks for anything more complex.
5. If a command does not work or is unreliable, document it in the Limitations section rather than presenting it as supported.
6. Do not add features or commands that require third-party tools unless clearly marked as alternatives (e.g., `mdfind` for Spotlight search).
7. When in doubt, prefer accuracy over completeness.
