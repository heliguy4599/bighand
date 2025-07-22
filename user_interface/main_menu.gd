class_name MainMenu
extends Control

signal game_start_request

@export var start_button: Button
@export var config_button: Button
@export var quit_button: Button
@export var view_switcher: ViewSwitcher


func _ready() -> void:
	start_button.pressed.connect(game_start_request.emit)
	config_button.pressed.connect(view_switcher.set_visible_child.bind(&"ConfigScreen"))
	quit_button.pressed.connect(func () -> void: get_tree().quit())
	start_button.grab_focus()
