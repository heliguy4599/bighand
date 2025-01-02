extends Node2D


const MOVEMENT_SPEED := 200.0


@onready var view_scroller: Node2D = $ViewScroller
@onready var car: Car = $Car
@onready var hand: Hand = $Hand

var max_car_x := 0.0


func _process(delta: float) -> void:
	var viewport_rect = get_viewport_rect()
	viewport_rect.position -= get_viewport_transform().origin
	var left_movement_threshold = viewport_rect.position.x + (viewport_rect.size.x * 0.33)
	var right_movement_threshold = viewport_rect.position.x + (viewport_rect.size.x * 0.67)

	var movement_offset = hand.position.x - left_movement_threshold
	if movement_offset < 0:
		view_scroller.position.x += movement_offset * delta

	movement_offset = hand.position.x - right_movement_threshold
	if movement_offset > 0:
		view_scroller.position.x += movement_offset * delta

func _physics_process(delta: float) -> void:
	#if car.position.x > max_car_x:
		#max_car_x = car.position.x
		#view_scroller.position.x = max_car_x
	pass
