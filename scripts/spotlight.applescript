-- Show media item or path in Photos. argv: path or mediaId
on run argv
	if (count of argv) < 1 then
		return "Usage: spotlight.applescript <path|media_id>"
	end if
	set val to item 1 of argv

	tell application "Photos"
		try
			spotlight val
		end try
	end tell
	return "shown"
end run
