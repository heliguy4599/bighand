class_name Pickupable
extends RigidBody2D

@export var durability: float = -1
@export var breakable_more_than_once: bool = true

var _is_broken := false
func is_broken() -> bool:
	return _is_broken


func _ready() -> void:
	assert(durability >= -1, "Pickupable.durability cannot be lower than -1")
	assert(
		durability == -1 or durability >= 0,
		"Pickupable.durability cannot be a negative non-whole-number",
	)


func grab() -> void: pass


func ungrab() -> void: pass


func do_break() -> void: pass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if durability == -1 or (_is_broken and not breakable_more_than_once):
		return
	for i in range(state.get_contact_count()):
		if state.get_contact_impulse(i).length() > durability:
			_is_broken = true
			do_break()
			return
