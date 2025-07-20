class_name MainMenu
extends Control

@export var start_button: Button
@export var config_button: Button
@export var quit_button: Button
@export var view_switcher: ViewSwitcher


func _ready() -> void:
	start_button.pressed.connect(func ():
		print("start button pressed")
	)
	config_button.pressed.connect(func ():
		view_switcher.set_visible_child(&"ConfigScreen")
	)
	quit_button.pressed.connect(func ():
		print("quit button pressed")
	)
