class_name FuckingStupid
extends Control

var thing := Node

@export var file_dialog: FileDialog


func _ready() -> void:
	file_dialog.show()
	file_dialog.file_selected.connect(func (path: String) -> void:
		print(path)
		#var file := FileAccess.open(path, FileAccess.READ)
		#print(file.get_as_text())
	)
