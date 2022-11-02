extends CanvasLayer

onready var timer = get_node("TileMap/Timer")
onready var map = get_node("TileMap")


onready var defaultPos = 0
onready var scrollSpeed = 120

func _process(delta):
	
	#Background scrolling. It's supposed to emulate an infinitely moving background.
	map.position.y += scrollSpeed * delta
	if map.position.y >= 127:
		map.position.y = defaultPos
	
	
