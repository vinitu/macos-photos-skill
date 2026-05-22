-- Export media to path. argv: albumName outputPath [using originals]
on run argv
	if (count of argv) < 2 then
		return "Usage: export.applescript <album> <output_path> [using originals]"
	end if
	set albumName to item 1 of argv
	set outPath to item 2 of argv
	set useOriginals to (count of argv) ≥ 3 and (item 3 of argv) is "using originals"
	set pathFile to POSIX file outPath

	tell application "Photos"
		set mediaList to every media item of album albumName
		export mediaList to pathFile
	end tell
	return "exported"
end run
