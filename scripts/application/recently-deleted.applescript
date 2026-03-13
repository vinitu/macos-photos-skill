-- Get the Recently Deleted album name.
on run argv
	tell application "Photos"
		return name of recently deleted album
	end tell
end run
