extends Node2D

onready var appleCount = "user://save.txt"

var apples

# Called when the node enters the scene tree for the first time.
func _ready():
	var save = File.new()
	if save.file_exists(appleCount):
		save.open(appleCount, File.READ)
		apples = save.get_var()
		save.close()
		
	$Control/Label.text = str(apples)
	if apples >= 40:
		pass
	elif apples >= 25 and apples <= 40:
		pass
	elif apples < 20:
		pass
