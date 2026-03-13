# macos-photos-skill

An AI agent skill for interacting with Apple Photos.app on macOS via AppleScript.

## What This Does

Provides structured documentation and ready-to-use `osascript` commands that let AI agents (Claude, etc.) work with the Photos.app library on macOS. Covers reading albums, searching photos, getting metadata, exporting, importing, and managing favorites.

## Prerequisites

- macOS with Photos.app installed (ships with macOS by default)
- Terminal access with Automation permissions for Photos (System Settings > Privacy & Security > Automation)
- `osascript` available in PATH (included with macOS)

## Installation

```bash
npx skills add vinitu/macos-photos-skill
```

Or with [skills.sh](https://skills.sh):

```bash
skills.sh add vinitu/macos-photos-skill
```

## Scope

This skill covers:

- Listing and browsing albums, folders, and media items
- Searching photos by filename, date, keyword, and favorite status
- Reading photo metadata (name, date, description, keywords, location, dimensions)
- Creating and deleting albums
- Adding photos to albums
- Exporting photos to a folder (copies or originals)
- Importing photos into the library or a specific album
- Favoriting and unfavoriting photos

## Usage

The main reference is `SKILL.md`. It contains all supported operations with copy-paste `osascript` commands. AI agents load this file as context when they need to interact with Photos.app.

### Quick example

From the skill directory (or path where scripts are installed):

```bash
# List all album names
osascript scripts/album/list.applescript
# Export album "Favorites" to a folder
osascript scripts/media/export.applescript "Favorites" "/path/to/dest"
```

For more operations (search, create album, favorite, import), see `SKILL.md` and scripts under `scripts/`.

## Limitations

Photos.app AppleScript support is read-heavy. Many write operations (editing photos, setting metadata fields beyond favorites, removing items from albums) are not available. See the Limitations section in `SKILL.md` for the full list.

## License

MIT - see [LICENSE](LICENSE).
