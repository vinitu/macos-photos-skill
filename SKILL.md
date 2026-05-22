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
- `scripts/commands/application/*`
- `scripts/commands/folder/*`
- `scripts/commands/media/*`
- `scripts/commands/photo/*`
- `scripts/commands/slideshow/*`

## Output Rules

- Commands return JSON by default where the AppleScript already produces JSON; otherwise passes through plain text.
- `--json`, `--plain`, and `--format=plain|json` are not supported.

## Commands

### Album

```bash
scripts/commands/album/create.sh
scripts/commands/album/delete.sh
scripts/commands/album/list.sh
```

### Application

```bash
scripts/commands/application/favorites-album.sh
scripts/commands/application/recently-deleted.sh
```

### Folder

```bash
scripts/commands/folder/list.sh
```

### Media

```bash
scripts/commands/media/duplicate.sh
scripts/commands/media/export.sh
scripts/commands/media/favorite.sh
scripts/commands/media/get.sh
scripts/commands/media/import.sh
scripts/commands/media/list.sh
scripts/commands/media/search.sh
```

### Photo

```bash
scripts/commands/photo/spotlight.sh
```

### Slideshow

```bash
scripts/commands/slideshow/start.sh
scripts/commands/slideshow/stop.sh
```

## JSON Contract

Media object:

- `id` (string)
- `name` (string)
- `filename` (string)
- `date` (string, ISO 8601)
- `description` (string or null)
- `keywords` (list of strings)
- `favorite` (boolean)
- `width` (integer)
- `height` (integer)

Album object:

- `name` (string)
- `count` (integer)

Scalar envelopes:

- `success/failure`: `{"success": true/false, "error": "..."}`

## Safety Boundaries

- Album delete, create, and write actions must be explicit.
- Internal AppleScript files are not public API.
