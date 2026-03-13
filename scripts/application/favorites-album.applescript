-- Get the Favorites album name.
on run argv
	tell application "Photos"
		return name of favorites album
	end tell
end run
