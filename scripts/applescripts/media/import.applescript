-- Import files into Photos. argv: path [albumName]
on run argv
	if (count of argv) < 1 then
		return "Usage: import.applescript <path> [album]"
	end if
	set pathStr to item 1 of argv
	set pathFile to POSIX file pathStr as alias

	tell application "Photos"
		if (count of argv) ≥ 2 then
			import pathFile into album (item 2 of argv)
		else
			import pathFile
		end if
	end tell
	return "imported"
end run
