class_name Car
extends Pickupable

var accel := 10000.0
var should_reverse := false


func _ready() -> void:
	body_entered.connect(func(body: Node):
		if (not should_reverse) and body is Hand:
			on_hand_collision()
	)


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if not should_reverse:
		apply_central_force(Vector2(accel, 0))


func on_hand_collision():
	should_reverse = true
	apply_central_impulse(-linear_velocity * mass)
	apply_central_impulse(Vector2(-200 * mass, 0))
	await get_tree().create_timer(1).timeout
	should_reverse = false
