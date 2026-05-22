---
name: macos-photos
description: Photos.app integration on macOS for AI agents via AppleScript/JXA.
---

# macOS Photos

Use this skill when the task is about Apple Photos.app on macOS.

## Main Rule

Use only `scripts/commands`.
Do not call `scripts/applescripts` directly.

## Requirements

- macOS with Photos.app
- Automation permissions for the terminal.

## Public Interface

Run commands from `scripts/commands`:

- `scripts/commands/album/*`
- `scripts/commands/photo/*`

## Output Rules

- Commands return JSON by default where the AppleScript already produces JSON; otherwise passes through plain text.
- `--json`, `--plain`, and `--format=plain|json` are not supported.

## Commands

Album:

```bash
scripts/commands/album/create.sh
scripts/commands/album/delete.sh
scripts/commands/album/list.sh
```

Photo:

```bash
scripts/commands/photo/spotlight.sh
```

## Safety Boundaries

- Album delete, create, and write actions must be explicit.
- Internal AppleScript files are not public API.
