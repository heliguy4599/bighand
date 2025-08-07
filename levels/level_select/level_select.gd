class_name LevelSelect
extends StaticBody2D

signal level_selected(metadata: LevelMetadata)


func _on_level_drop_body_entered(body: Node2D) -> void:
	if body is SelectableLevel:
		level_selected.emit(body.level_metadata)
