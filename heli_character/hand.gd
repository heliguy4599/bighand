class_name Hand
extends RigidBody2D


const SPEED := 1000.0
const ACCEL := 0.2
const GRABBING_RANGE := 200.0


@export var body: Body


var grabbed_object: Pickupable = null
var to_be_grabbed: Pickupable = null
var is_visually_grabbed := false


@onready var pickup_area: Area2D = $PickupArea
@onready var hand_open_back: Sprite2D = $HandOpenBack
@onready var hand_open_front: Sprite2D = $HandOpenFront
@onready var hand_closed_front: Sprite2D = $HandClosedFront


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
	body.point_to_hand(global_position)
	if to_be_grabbed != null:
		to_be_grabbed.modulate = Color.WHITE
	to_be_grabbed = determine_grabbable_object()


func determine_grabbable_object() -> Pickupable:
	if grabbed_object != null or is_visually_grabbed:
		return null

	var bodies := pickup_area.get_overlapping_bodies()
	if bodies.is_empty():
		return null

	for _body in bodies:
		if _body is Pickupable:
			_body.modulate = Color(1, 0.621, 0.621)
			return _body

	return null


func grab():
	if to_be_grabbed == null:
		grab_and_miss()
		return

	grabbed_object = to_be_grabbed
	to_be_grabbed.grab(self)
	set_visual_grab(true)


func ungrab():
	if grabbed_object == null:
		return

	grabbed_object.ungrab()
	grabbed_object = null

	set_visual_grab(false)


func set_visual_grab(is_grabbed: bool):
	is_visually_grabbed = is_grabbed
	hand_open_back.visible = not is_grabbed
	hand_open_front.visible = not is_grabbed
	hand_closed_front.visible = is_grabbed


func grab_and_miss():
	set_visual_grab(true)
	await get_tree().create_timer(0.2).timeout
	set_visual_grab(false)
