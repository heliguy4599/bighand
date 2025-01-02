class_name Car
extends Pickupable

const ACCEL := 500.0
var speed := 100.0
var on_ground := false


func _ready() -> void:
	body_entered.connect(func(body: Node):
		if not speed < 0:
			if body is Hand:
				on_hand_collision()
			elif body is Pickupable and body.hand != null:
				on_hand_collision()
	)


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in range(state.get_contact_count()):
		if absf(state.get_contact_local_normal(i).angle_to(-global_transform.y)) < deg_to_rad(40):
			on_ground = true
			return

	on_ground = false


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if on_ground:
		if linear_velocity.x > speed:
			apply_central_force(Vector2(-ACCEL * mass, 0))
		else:
			apply_central_force(Vector2(ACCEL * mass, 0))


func on_hand_collision():
	var old_speed := speed
	speed = -150
	await get_tree().create_timer(1.3).timeout
	speed = old_speed
