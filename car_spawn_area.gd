class_name CarSpawnArea
extends Area2D

const CAR_SCENE: PackedScene = preload("res://car.tscn")
const exited_cars: Array[Car] = []

@export var marker: Marker2D = null
@export var total_cars_to_spawn: int = -1

@onready var timer: Timer = $Timer

var total_cars_spawned := 0


func _ready() -> void:
	assert(total_cars_to_spawn > -2, "car_spawn_area.total_cars_to_spawn cannot be lower than -1")
	timer.timeout.connect(spawn_car)
	body_exited.connect(func (body: Node2D): 
		if body is Car and not body in exited_cars:
			timer.start()
			exited_cars.append(body)
	)


func spawn_car(override_total = false) -> void:
	if (
		total_cars_to_spawn != -1
		and total_cars_spawned >= total_cars_to_spawn
		and not override_total
	):
		return

	total_cars_spawned += 1
	var car = CAR_SCENE.instantiate()
	car.global_position = marker.global_position if marker != null else global_position
	add_sibling(car)
