-- List media items. argv: [albumName] or "library" [limit]
-- Default limit 50. One line per item: filename or name.
on run argv
	set albumName to "library"
	set limit to 50
	if (count of argv) ≥ 1 then set albumName to item 1 of argv
	if (count of argv) ≥ 2 then set limit to (item 2 of argv) as integer

	tell application "Photos"
		set mediaList to {}
		if albumName is "library" then
			set mediaList to (every media item)
		else
			set mediaList to (every media item of album albumName)
		end if
		set output to ""
		set n to 0
		repeat with m in mediaList
			if n ≥ limit then exit repeat
			set output to output & (filename of m) & linefeed
			set n to n + 1
		end repeat
		return output
	end tell
end run
