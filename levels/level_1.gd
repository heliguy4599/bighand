class_name Level1
extends StaticBody2D

@onready var car_win_area: Area2D = $CarWinArea
@onready var car_spawn_area: CarSpawnArea = $CarSpawnArea

var cars_deleted := 0
var exited_cars: Array[Car] = []


func _ready() -> void:
	car_win_area.body_entered.connect(func (body: Node2D):
		if body is Car:
			body.queue_free()
			cars_deleted += 1
			print("Cars Deleted: ", cars_deleted)
	)
	car_spawn_area.spawn_car()
