-- List folder (source) names in Photos. One per line.
on run argv
	tell application "Photos"
		set folders to every folder
		set output to ""
		repeat with f in folders
			set output to output & (name of f) & linefeed
		end repeat
		return output
	end tell
end run
