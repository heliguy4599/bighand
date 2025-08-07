class_name Level1
extends Level

const TOTAL_CARS := 1

@onready var car_win_area: Area2D = $CarWinArea
@onready var car_spawn_area: CarSpawnArea = $CarSpawnArea
@onready var car_delete_area: Area2D = $CarDeleteArea

var cars_saved := 0
var cars_removed := 0
var exited_cars: Array[Car] = []


func _ready() -> void:
	car_win_area.body_entered.connect(func (body: Node2D) -> void:
		if body is Car:
			body.queue_free()
			cars_saved += 1
	)
	car_delete_area.body_entered.connect(func (body: Node2D) -> void:
		if body is Car:
			body.queue_free()
	)
	car_spawn_area.total_cars_to_spawn = TOTAL_CARS
	car_spawn_area.spawn_car()


func _do_end_if_needed() -> void:
	if cars_removed < TOTAL_CARS:
		return
	var ellapsed_time := _get_ellapsed_time()
	var results := LevelResults.new(
		ellapsed_time,
		time_bonus_threshold_seconds,
		cars_saved > TOTAL_CARS / 2,
		cars_saved == TOTAL_CARS,
		ellapsed_time <= time_bonus_threshold_seconds
	)
	ended.emit(results)


func _on_car_spawned(car: Car) -> void:
	car.tree_exited.connect(func () -> void:
		cars_removed += 1
		_do_end_if_needed()
	)
