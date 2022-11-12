extends CanvasLayer

onready var timer = get_node("TileMap/Timer")
onready var map = get_node("TileMap")


onready var defaultPos = 0
onready var scrollSpeed : float = 100

var bossStarted = false
var canScroll = true

func _process(delta):
	
	#Background scrolling. It's supposed to emulate an infinitely moving background.
	if bossStarted == false:
		map.position.y += scrollSpeed * delta
		if map.position.y >= 157:
			map.position.y = defaultPos
	else:
		if canScroll == true:
			stopScrolling(delta)
		
	
	
func stopScrolling(delta):
	map.position.y += scrollSpeed * delta
	scrollSpeed -= 0.1
	if map.position.y >= 550 and map.position.y <= 700:
		scrollSpeed -= 0.25
	elif map.position.y >= 700:
		canScroll = false
		

func _on_Stage1_bossStart():
	bossStarted = true
	print("aa")
