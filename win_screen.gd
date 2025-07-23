class_name WinScreen
extends StaticBody2D

signal do_next_level
signal do_restart

@export var player_container: PlayerContainer
@export var hand_start_marker: Marker2D
@export var quit_area: Area2D
@export var next_level_area: Area2D
@export var lever_handle: Pickupable

@export var vbox: VBoxContainer
#@export var title_label: Label
@export var time_taken_label: Label
@export var speedy_threshold_label: Label
@export var passing_label: Label
@export var perfect_label: Label
@export var speedy_label: Label


func _ready() -> void:
	player_container.set_hand_position(hand_start_marker.global_position)


func display_results(results: LevelResults) -> void:
	time_taken_label.text = "Time Taken: " + Utils.prettify_time(results.time)
	speedy_threshold_label.text = "Speedy Threshold: " + Utils.prettify_time(results.speedy_threshold)
	passing_label.visible = results.passing
	perfect_label.visible = results.perfect
	speedy_label.visible = results.speedy


func _on_restart_area_body_entered(body: Node2D) -> void:
	if body == lever_handle:
		do_restart.emit()


func _on_next_level_area_body_entered(body: Node2D) -> void:
	if body == lever_handle:
		do_next_level.emit()
