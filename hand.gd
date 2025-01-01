class_name Hand
extends RigidBody2D


const SPEED := 1000.0
const ACCEL := 0.2
const GRABBING_RANGE := 200.0


@onready var pickup_area: Area2D = $PickupArea


var grabbed_object: Pickupable = null


func _ready() -> void:
	pickup_area.body_exited.connect(func(body):
		if body == grabbed_object:
			ungrab()
	)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("grab"):
		if grabbed_object == null:
			grab()
		else:
			ungrab()


func _physics_process(delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_speed := input * SPEED
	apply_central_force((desired_speed - linear_velocity) * ACCEL * mass)


func grab():
	if grabbed_object != null:
		return

	var bodies := pickup_area.get_overlapping_bodies()
	if bodies.is_empty():
		return

	for body in bodies:
		if body is Pickupable:
			grabbed_object = body
			grabbed_object.grab(self)
			break


func ungrab():
	if grabbed_object == null:
		return

	grabbed_object.ungrab()
	grabbed_object = null
