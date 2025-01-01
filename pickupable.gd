class_name Pickupable
extends RigidBody2D


const LINEAR_GRAB_FORCE := 300.0
const LINEAR_DAMP := 10.0
const ANGULAR_GRAB_FROCE := 300000.0
const ANGULAR_DAMP := 10.0

var offset := Vector2(0, 0)
var hand: Hand = null
var last_rotation := 0.0


func _physics_process(_delta: float) -> void:
	if hand == null:
		return

	var desired_position := hand.position + offset
	var distance_difference := desired_position - position
	var linear_force := distance_difference * LINEAR_GRAB_FORCE * mass
	apply_central_force(linear_force)

	var angular_force := angle_difference(rotation, last_rotation) * ANGULAR_GRAB_FROCE * mass
	apply_torque(angular_force)

func grab(p_hand: Hand):
	hand = p_hand
	offset = position - hand.position
	last_rotation = rotation
	linear_damp = LINEAR_DAMP
	angular_damp = ANGULAR_DAMP

func ungrab():
	hand = null
	linear_damp = 0
	angular_damp = 0
