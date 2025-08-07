class_name CarSpawnArea
extends Area2D

signal car_spawned(car: Car)

const CAR_SCENE: PackedScene = preload("res://car/car.tscn")

@export var marker: Marker2D = null
@export var total_cars_to_spawn: int = -1

@onready var timer: Timer = $Timer

var exited_cars: Array[Car] = []
var total_cars_spawned := 0


func _ready() -> void:
	assert(total_cars_to_spawn > -2, "car_spawn_area.total_cars_to_spawn cannot be lower than -1")
	timer.timeout.connect(spawn_car)
	body_exited.connect(func (body: Node2D) -> void: 
		if body is Car and not body in exited_cars:
			timer.start()
			exited_cars.append(body)
	)


func spawn_car(override_total := false) -> void:
	if (
		total_cars_to_spawn != -1
		and total_cars_spawned >= total_cars_to_spawn
		and not override_total
	):
		return

	total_cars_spawned += 1
	var car: Car = CAR_SCENE.instantiate()
	car.hide()
	add_sibling(car)
	car.global_position = marker.global_position if marker != null else global_position
	await get_tree().physics_frame
	car.show()
	car_spawned.emit(car)
