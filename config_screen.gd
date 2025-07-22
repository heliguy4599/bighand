class_name ConfigScreen
extends Control

@export var volume_slider: HSlider
@export var volume_percentage_label: Label


func _ready() -> void:
	volume_slider.value = 50


func _on_volume_value_changed(value: float) -> void:
	volume_percentage_label.text = ("%3d" % value) + "%"
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index(&"Master"),
		-200.0 if value == 0.0 else (value * 0.5) - 50,
	)


func _on_full_screen_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if toggled_on else DisplayServer.WINDOW_MODE_WINDOWED
	)
