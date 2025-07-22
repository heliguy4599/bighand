class_name WinScreen
extends StaticBody2D

@export var player_container: PlayerContainer
@export var hand_start_marker: Marker2D
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
