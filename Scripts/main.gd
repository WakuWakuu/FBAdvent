extends Node2D


var appleNumber = 0
var life = 3
var power = 0
var frozen = false


signal appleCollected

onready var player = get_node("chars/player")
onready var appleGroup = get_tree().get_nodes_in_group("Apple")

onready var appleCounter = get_node("GUI/Control/In-game/Score/AppCounter")
onready var life1 = get_node("GUI/Control/In-game/Score/Lives/CanvasLayer/life1")
onready var life2 = get_node("GUI/Control/In-game/Score/Lives/CanvasLayer/life2")
onready var life3 = get_node("GUI/Control/In-game/Score/Lives/CanvasLayer/life3")
onready var powerBar = get_node("GUI/Control/In-game/Score/Power/power/TextureProgress")
onready var invert = get_node("Invert")
onready var bulletClearArea = $BulletClear


func _ready():
	invert.visible = false
	player.global_position = $Position2D.global_position
	

func _process(delta):
	
	appleCheck(); meleeCheck()
	BHPatternManager.deregister_other_collider(bulletClearArea)
				
	
	
	if appleNumber < 0:
		appleNumber = 0
		
	if power == 100:
		power = 0
		BHPatternManager.register_other_collider(bulletClearArea)
		appleClear()
		$Music/SFX/clear.play()
		
	
	appleCounter.text = str(appleNumber)
	powerBar.value = power
	
func appleCount():
	
	appleNumber += 1
	$Music/SFX/appleCollect.play()

func powerGauge():
	
	power += 25
	$Music/SFX/powerLevelUp.play()
	print(power)

func meleeCheck():
	if get_tree().get_nodes_in_group("Owl").empty() != true:
			for i in get_tree().get_nodes_in_group("Owl").size():
				var apples = get_tree().get_nodes_in_group("Owl")
				if not apples[i].is_connected("powerIncrease", self, "powerGauge"):
					apples[i].connect("powerIncrease", self, "powerGauge")
					
func appleCheck():
	if get_tree().get_nodes_in_group("Apple").empty() != true:
		for i in get_tree().get_nodes_in_group("Apple").size():
			var apples = get_tree().get_nodes_in_group("Apple")
			if not apples[i].is_connected("appleCollected", self, "appleCount"):
				apples[i].connect("appleCollected", self, "appleCount")

func _on_player_death():
	
	#power = 0 #Commented out for debug purposes
	freeze(0.01, 3)
	invert.visible = true
	yield(get_tree().create_timer(0.01 * 3), "timeout")
	
	invert.visible = false
	$Music/SFX/clearDeath.play()
	$Music/SFX/respawn.play()
	life -= 1
	appleNumber -= 2
	player.global_position = $Position2D.global_position	
	BHPatternManager.register_other_collider(bulletClearArea)
	
	
	
	if life == 3:
		life3.visible = true; life2.visible = true; life1.visible = true
		
	elif life == 2:
		life3.visible = false; life2.visible = true; life1.visible = true
		
	elif life == 1:
		life2.visible = false; life3.visible = false; life1.visible = true

	elif life == 0:
		life1.visible = false; life2.visible = false; life3.visible = false

	elif life == -1:
		print("gameover")

func freeze(timeScale, length):
	frozen = true
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(length * timeScale), "timeout")
	frozen = false
	Engine.time_scale = 1

func appleClear():
	print("a")
	if get_tree().get_nodes_in_group("Apple").empty() != true:
		for i in appleGroup.size():
			print(appleGroup[i])
			appleGroup[i].connect("_on_Apple_area_entered", self, "appleClear")
			emit_signal("_on_Apple_area_entered")
		