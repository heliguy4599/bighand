class_name Level1
extends StaticBody2D

const TOTAL_CARS := 3

@onready var car_win_area: Area2D = $CarWinArea
@onready var car_spawn_area: CarSpawnArea = $CarSpawnArea
@onready var win_screen: WinScreen = $WinScreen
@onready var car_delete_area: Area2D = $CarDeleteArea

var cars_saved := 0
var cars_lost := 0
var exited_cars: Array[Car] = []


func _ready() -> void:
	car_win_area.body_entered.connect(func (body: Node2D):
		if body is Car:
			body.queue_free()
			cars_saved += 1
			_do_end_if_needed()
	)
	car_delete_area.body_entered.connect(func (body: Node2D):
		if body is Car:
			body.queue_free()
			cars_lost += 1
			_do_end_if_needed()
	)
	car_spawn_area.total_cars_to_spawn = TOTAL_CARS
	car_spawn_area.spawn_car()


func _do_end_if_needed() -> void:
	if cars_saved + cars_lost < TOTAL_CARS:
		return
	win_screen.cars_saved = cars_saved
	win_screen.cars_lost = cars_lost
	win_screen.show()
