-- Start slideshow.
on run argv
	tell application "Photos"
		start slideshow
	end tell
	return "started"
end run
