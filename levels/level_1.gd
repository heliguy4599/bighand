class_name Level1
extends StaticBody2D

const CAR_SCENE: PackedScene = preload("res://car.tscn")

@onready var car_win_area: Area2D = $CarWinArea
@onready var car_spawn_area: Area2D = $CarSpawnArea
@onready var car_spawn_marker: Marker2D = $CarSpawnArea/CarSpawnMarker
@onready var timer: Timer = $Timer

var cars_deleted := 0
var exited_cars: Array[Car] = []


func _ready() -> void:
	car_win_area.body_entered.connect(func (body: Node2D):
		if body is Car:
			body.queue_free()
			cars_deleted += 1
			print("Cars Deleted: ", cars_deleted)
	)
	timer.timeout.connect(_spawn_car)
	car_spawn_area.body_exited.connect(func (body: Node2D):
		if body is Car and not body in exited_cars:
			timer.start()
	)
	_spawn_car()


func _spawn_car() -> void:
	var car: Car = CAR_SCENE.instantiate()
	car.global_position = car_spawn_marker.global_position
	add_child(car)
