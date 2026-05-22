-- Stop slideshow.
on run argv
	tell application "Photos"
		stop slideshow
	end tell
	return "stopped"
end run
