-- Search media. argv: by filename|date|keyword|favorite value
on run argv
	if (count of argv) < 2 then
		return "Usage: search.applescript <by> <value>"
	end if
	set searchBy to item 1 of argv
	set searchVal to item 2 of argv

	tell application "Photos"
		set found to {}
		if searchBy is "filename" then
			set found to (every media item whose filename contains searchVal)
		else if searchBy is "favorite" then
			set isFav to (searchVal is "true")
			set found to (every media item whose favorite is isFav)
		else if searchBy is "keyword" then
			set found to (every media item whose keywords contains searchVal)
		else
			return "Unknown search by: " & searchBy
		end if
		set output to ""
		repeat with m in found
			set output to output & (filename of m) & linefeed
		end repeat
		return output
	end tell
end run
