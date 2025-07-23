class_name GameHolder
extends Node

const END_SCREEN_SCENE: PackedScene = preload("res://win_screen.tscn")

var current_level_metadata: LevelMetadata


func _ready() -> void:
	var level_select: LevelSelect = load("res://levels/level_select.tscn").instantiate()
	add_child(level_select)
	level_select.level_selected.connect(start_level)


func _remove_all_children() -> void:
	for child in get_children():
		child.queue_free()


func start_level(metadata: LevelMetadata) -> void:
	var scene: PackedScene = load(metadata.scene_path)
	_remove_all_children()
	var level_instance: Level = scene.instantiate()
	level_instance.ended.connect(show_end_screen)
	add_child.call_deferred(level_instance)
	current_level_metadata = metadata


func show_end_screen(results: LevelResults) -> void:
	var end_screen_instance: WinScreen = END_SCREEN_SCENE.instantiate()
	_remove_all_children()
	add_child.call_deferred(end_screen_instance)
	end_screen_instance.display_results(results)
	end_screen_instance.do_restart.connect(start_level.bind(current_level_metadata))
	end_screen_instance.do_next_level.connect(print.bind("do_next_level_triggered"))
