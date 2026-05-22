-- Get media item metadata. argv: index [albumName] or albumName index
on run argv
	if (count of argv) < 1 then
		return "Usage: get.applescript <index> [album] or <album> <index>"
	end if

	tell application "Photos"
		set m to missing value
		if (count of argv) is 1 then
			set idx to (item 1 of argv) as integer
			set m to item idx of (every media item)
		else
			set albumName to item 1 of argv
			set idx to (item 2 of argv) as integer
			set m to media item idx of album albumName
		end if
		set output to "id: " & (id of m) & linefeed
		set output to output & "name: " & (name of m) & linefeed
		set output to output & "filename: " & (filename of m) & linefeed
		set output to output & "date: " & (date of m) & linefeed
		set output to output & "description: " & (description of m) & linefeed
		set output to output & "keywords: " & (keywords of m) & linefeed
		set output to output & "favorite: " & (favorite of m) & linefeed
		try
			set output to output & "dimensions: " & (dimensions of m)
		end try
		return output
	end tell
end run
