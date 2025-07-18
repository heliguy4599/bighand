class_name Car
extends Pickupable

@export var accel := 500.0
@export var speed := 100.0

var on_ground := false


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in range(state.get_contact_count()):
		if absf(state.get_contact_local_normal(i).angle_to(-global_transform.y)) < deg_to_rad(40):
			on_ground = true
			return

	on_ground = false


func _physics_process(delta: float) -> void:
	if on_ground:
		if linear_velocity.x > speed:
			apply_central_force(Vector2(-accel * mass, 0))
		else:
			apply_central_force(Vector2(accel * mass, 0))
