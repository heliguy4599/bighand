class_name ViewSwitcher
extends Control


func _ready() -> void:
	set_visible_child(get_child(0).name)


func set_visible_child(page_name: StringName) -> void:
	for child in get_children():
		if child is Control:
			child.visible = page_name == child.name
