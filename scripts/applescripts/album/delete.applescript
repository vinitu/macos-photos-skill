-- Delete an album. argv: albumName
on run argv
	if (count of argv) < 1 then
		return "Usage: delete.applescript <album_name>"
	end if
	set albumName to item 1 of argv

	tell application "Photos"
		delete album albumName
	end tell
	return "deleted"
end run
