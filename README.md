# macOS Photos Skill

This repo stores an AI agent skill for Apple Photos.app on macOS.

The public interface is `scripts/commands`.
`scripts/applescripts` stores internal AppleScript backends and dictionary-aligned coverage.

## Installation

```bash
npx skills add vinitu/macos-photos-skill
```

Or with [skills.sh](https://skills.sh):

```bash
skills.sh add vinitu/macos-photos-skill
```

## Prerequisites

- macOS with Photos.app
- Automation permission granted to your terminal app

## Public Interface

Run skill actions with:

```bash
scripts/commands/<entity>/<action>.sh [args...]
```

Output rules:

- Commands return JSON by default unless noted otherwise.
- `--json`, `--plain`, and `--format=plain|json` are not supported.

## Backend Map

- `scripts/commands/album/*` → AppleScript in `scripts/applescripts/album/*`
- `scripts/commands/photo/*` → AppleScript in `scripts/applescripts/photo/*`

`scripts/applescripts` is internal. Do not call it directly from the skill instructions.

## Command Surface

Album:

- `scripts/commands/album/create.sh`
- `scripts/commands/album/delete.sh`
- `scripts/commands/album/list.sh`

Photo:

- `scripts/commands/photo/spotlight.sh`

## Validation

```bash
make compile
make test
```

`make test` runs live checks against Photos.app and expects Photos to be available.

## Known Limits

- Photos must be running for most commands to work.
- TCC permissions (Automation) must be granted to the terminal or parent process.
- Photos AppleScript support is read-heavy; many write operations are not available.
