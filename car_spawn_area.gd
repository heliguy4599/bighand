class_name CarSpawnArea
extends Area2D

const CAR_SCENE: PackedScene = preload("res://car.tscn")
const exited_cars: Array[Car] = []

@export var marker: Marker2D = null

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(spawn_car)
	body_exited.connect(func (body: Node2D): 
		if body is Car and not body in exited_cars:
			timer.start()
			exited_cars.append(body)
	)


func spawn_car() -> void:
	var car = CAR_SCENE.instantiate()
	car.position = marker.position if marker != null else position
	(marker.add_sibling if marker != null else add_sibling).call(car)
