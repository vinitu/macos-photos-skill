-- Duplicate a media item. argv: mediaId or album index
on run argv
	if (count of argv) < 1 then
		return "Usage: duplicate.applescript <media_id>"
	end if
	set mediaId to item 1 of argv

	tell application "Photos"
		set m to first media item whose id is mediaId
		duplicate m
	end tell
	return "duplicated"
end run
