-- List album names. One per line.
tell application "Photos"
	set albumList to every album
	set output to ""
	repeat with a in albumList
		set output to output & (name of a) & linefeed
	end repeat
	return output
end tell
