class_name Utils
extends Node


static func prettify_time(seconds: float) -> String:
	var minutes := int(seconds / 60)
	var whole_seconds := int(seconds)
	var display_seconds := whole_seconds - (minutes * 60)
	var milleseconds := (seconds - whole_seconds) * 1000
	return "%3dm %2ds %3dms" % [minutes, display_seconds, milleseconds]
