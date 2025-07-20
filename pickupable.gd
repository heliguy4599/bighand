class_name Pickupable
extends RigidBody2D

@export var durability: float = 18_000.0
@export var breakable_more_than_once: bool = true

var _is_broken := false
func is_broken() -> bool:
	return _is_broken


func grab(): pass


func ungrab(): pass


func do_break():
	print("IM BROKEN")


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if _is_broken and not breakable_more_than_once:
		return
	for i in range(state.get_contact_count()):
		print(state.get_contact_impulse(i).length())
		if state.get_contact_impulse(i).length() > durability:
			_is_broken = true
			do_break()
			return
