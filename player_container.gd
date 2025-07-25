class_name PlayerContainer
extends Node2D

const CAMERA_MOVEMENT_STIFFNESS := 3.0

@export var enable_camera_movement: bool = true

@onready var camera: Camera2D = $Camera2D
@onready var hand: Hand = $Hand
@onready var player_body: Body = $Body


func set_hand_position(hand_position: Vector2) -> void:
	var hand_offset := player_body.global_position - hand.global_position
	hand.global_position = hand_position
	player_body.teleport(hand_position + hand_offset)


func _ready() -> void:
	camera.make_current()


func _physics_process(delta: float) -> void:
	if enable_camera_movement:
		_move_camera_to_hand(delta)


func _move_camera_to_hand(delta: float) -> void:
	var viewport_width := get_viewport_rect().size.x
	var camera_x := camera.position.x
	var left_movement_area := camera_x - (viewport_width / 6)
	var right_movement_area := camera_x + (viewport_width / 6)
	if (hand.position.x < left_movement_area):
		var movement_offset := hand.position.x - left_movement_area
		camera.position.x += movement_offset * delta * CAMERA_MOVEMENT_STIFFNESS
	elif (hand.position.x > right_movement_area):
		var movement_offset := hand.position.x - right_movement_area
		camera.position.x += movement_offset * delta * CAMERA_MOVEMENT_STIFFNESS
