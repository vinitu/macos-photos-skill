-- Set favorite on media. argv: mediaId true|false
on run argv
	if (count of argv) < 2 then
		return "Usage: favorite.applescript <media_id> <true|false>"
	end if
	set mediaId to item 1 of argv
	set isFav to (item 2 of argv is "true")

	tell application "Photos"
		set m to first media item whose id is mediaId
		set favorite of m to isFav
	end tell
	return "set"
end run
