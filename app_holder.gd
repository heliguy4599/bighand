class_name AppHolder
extends Node

const MAIN_MENU_SCENE: PackedScene = preload("res://user_interface/main_menu.tscn")
const GAME_HOLDER_SCENE: PackedScene = preload("res://game_holder.tscn")


func _ready() -> void:
	var main_menu: MainMenu = MAIN_MENU_SCENE.instantiate()
	main_menu.game_start_request.connect(_on_game_start)
	add_child(main_menu)
	print(Utils.prettify_time(62.2))


func _on_game_start() -> void:
	for child in get_children():
		child.queue_free()
	var game_holder: GameHolder = GAME_HOLDER_SCENE.instantiate()
	add_child(game_holder)
