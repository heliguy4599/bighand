class_name WinScreen
extends CanvasLayer

@onready var cars_saved_label: Label = $VBoxContainer/cars_saved_label
@onready var cars_lost_label: Label = $VBoxContainer/cars_lost_label


var cars_saved: int = 0:
	set(value):
		cars_saved_label.text = "Cars saved: %s" % value
		cars_saved = value

var cars_lost: int = 0:
	set(value):
		cars_lost_label.text = "Cars lost: %s" % value
		cars_lost = value
