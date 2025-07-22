class_name SelectableLevel
extends Pickupable


@export var level_metadata: LevelMetadata
@export var title_label: Label


func _ready() -> void:
	title_label.text = level_metadata.title
