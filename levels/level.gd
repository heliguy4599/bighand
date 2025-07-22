class_name Level
extends StaticBody2D

signal ended(results: LevelResults)

@onready var time_started := Time.get_unix_time_from_system()

@export var time_bonus_threshold_seconds: float


func _get_ellapsed_time() -> float:
	var current := Time.get_unix_time_from_system()
	return current - time_started
