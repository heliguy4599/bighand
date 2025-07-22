class_name LevelResults
extends RefCounted

var time: float
var speedy_threshold: float

var passing: bool
var perfect: bool
var speedy: bool

var extra_strings: Dictionary[String, String]


func _init(
	p_time: float,
	p_speedy_threshold: float,
	p_passing: bool,
	p_perfect: bool,
	p_speedy: bool,
	p_extra_strings: Dictionary[String, String] = {}
) -> void:
	time = p_time
	speedy_threshold = p_speedy_threshold
	passing = p_passing
	perfect = p_perfect
	speedy = p_speedy
	extra_strings = p_extra_strings
