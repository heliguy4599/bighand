extends Node2D


const MOVEMENT_SPEED := 2.0


@onready var view_scroller: Node2D = $ViewScroller


func _physics_process(delta: float) -> void:
	view_scroller.position += Vector2(MOVEMENT_SPEED, 0) * delta
