class_name Hand
extends RigidBody2D


const SPEED := 1000.0
const ACCEL := 0.2
const GRABBING_RANGE := 200.0


@export var body: Body


var grabbed_object: Pickupable = null
var to_be_grabbed: Pickupable = null
var is_visually_grabbed := false
var _grabbed_object_gravity := 0.0


@onready var pickup_area_group: Node2D = $PickupAreaGroup
@onready var laregest_pickup_area: Area2D = $PickupAreaGroup/PickupArea2
@onready var hand_open_back: Sprite2D = $HandOpenBack
@onready var hand_open_front: Sprite2D = $HandOpenFront
@onready var hand_closed_front: Sprite2D = $HandClosedFront
@onready var joints: Array[PinJoint2D] = [$PinJoint2DLeft, $PinJoint2DRight]


func _ready() -> void:
	laregest_pickup_area.body_exited.connect(func(exited_body: Node2D) -> void:
		if exited_body == grabbed_object:
			ungrab()
	)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("grab"):
		if grabbed_object == null:
			grab()
		else:
			ungrab()


func _physics_process(_delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_speed := input * SPEED
	var effective_mass := mass
	if grabbed_object != null:
		effective_mass += grabbed_object.mass

	apply_central_force((desired_speed - linear_velocity) * ACCEL * effective_mass)
	body.point_to_hand(global_position)
	if to_be_grabbed != null:
		to_be_grabbed.modulate = Color.WHITE

	to_be_grabbed = determine_grabbable_object()


func determine_grabbable_object() -> Pickupable:
	if grabbed_object != null or is_visually_grabbed:
		return null

	var pickup_areas := pickup_area_group.get_children()
	for area: Area2D in pickup_areas:
		var bodies: Array[Node2D] = area.get_overlapping_bodies()
		if bodies.is_empty():
			continue

		for overlapping_body in bodies:
			if not overlapping_body is Pickupable:
				continue

			overlapping_body.modulate = Color(1, 0.621, 0.621)
			return overlapping_body

	return null


func grab() -> void:
	if to_be_grabbed == null:
		grab_and_miss()
		return

	grabbed_object = to_be_grabbed
	_grabbed_object_gravity = grabbed_object.gravity_scale
	grabbed_object.gravity_scale = 0.0
	for joint in joints:
		joint.node_b = grabbed_object.get_path()

	to_be_grabbed.grab()
	set_visual_grab(true)


func ungrab() -> void:
	if grabbed_object == null:
		return

	for joint in joints:
		joint.node_b = get_path()

	grabbed_object.ungrab()
	grabbed_object.gravity_scale = _grabbed_object_gravity
	grabbed_object = null
	set_visual_grab(false)


func set_visual_grab(is_grabbed: bool) -> void:
	is_visually_grabbed = is_grabbed
	hand_open_back.visible = not is_grabbed
	hand_open_front.visible = not is_grabbed
	hand_closed_front.visible = is_grabbed


func grab_and_miss() -> void:
	set_visual_grab(true)
	await get_tree().create_timer(0.2).timeout
	set_visual_grab(false)
