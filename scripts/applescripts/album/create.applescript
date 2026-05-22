-- Create an album. argv: albumName
on run argv
	if (count of argv) < 1 then
		return "Usage: create.applescript <album_name>"
	end if
	set albumName to item 1 of argv

	tell application "Photos"
		set newAlbum to make new album
		set name of newAlbum to albumName
	end tell
	return "created"
end run
