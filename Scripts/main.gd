extends Node2D


var appleNumber = 0
var life = 3
var power = 0
var frozen = false
var stage = 1
var debug = false
var paused = false

signal appleCollected
signal powerCollected
signal powerSkillActivate

onready var loadingScreen = load("res://Scenes/Loading.tscn")

onready var stage1Loaded = load("res://Stages/Stage1.tscn")
var stage1
onready var stage2Loaded = load("res://Stages/Stage2.tscn")
var stage2

onready var player = get_node("chars/player")
onready var appleGroup = get_tree().get_nodes_in_group("Apple")

onready var appleCounter = get_node("GUI/Control/In-game/Score/AppCounter")
onready var skillDisplay = get_node("GUI/Control/In-game/Score/SkillName")
onready var life1 = get_node("GUI/Control/In-game/Score/Lives/CanvasLayer/life1")
onready var life2 = get_node("GUI/Control/In-game/Score/Lives/CanvasLayer/life2")
onready var life3 = get_node("GUI/Control/In-game/Score/Lives/CanvasLayer/life3")
onready var powerBar = get_node("GUI/Control/In-game/Score/Power/power/TextureProgress")
onready var invert = get_node("Invert")
onready var bulletClearArea = $BulletClear

onready var saveFile = "user://save.txt"

func _ready():
	var stage1 = stage1Loaded.instance()
	get_node("Stage").add_child(stage1)
	stage1.connect("changeStage", self, "stageChange")
	stage1.ready()
	invert.visible = false
	player.global_position = $Position2D.global_position
	saveApples()
	#getDebugMode()
	

func _process(delta):
	
	appleCheck(); meleeCheck(); powerCheck(); skillCheck() #; vibeCheck()
	inputCheck()
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

func powerSkill():
	emit_signal("powerSkillActivate")
	print("collected")
	$Music/SFX/skillCollect.play()

func meleeCheck():
	if get_tree().get_nodes_in_group("Owl").empty() != true:
		for i in get_tree().get_nodes_in_group("Owl").size():
			var owls = get_tree().get_nodes_in_group("Owl")
			if not owls[i].is_connected("powerIncrease", self, "powerGauge"):
				owls[i].connect("powerIncrease", self, "powerGauge")
				owls[i].connect("addLife", self, "lifeIncrease")
					
func appleCheck():
	if get_tree().get_nodes_in_group("Apple").empty() != true:
		for i in get_tree().get_nodes_in_group("Apple").size():
			var apples = get_tree().get_nodes_in_group("Apple")
			if not apples[i].is_connected("appleCollected", self, "appleCount"):
				apples[i].connect("appleCollected", self, "appleCount")

func powerCheck():
	if get_tree().get_nodes_in_group("Powerup").empty() != true:
		for i in get_tree().get_nodes_in_group("Powerup").size():
			var power = get_tree().get_nodes_in_group("Powerup")
			if not power[i].is_connected("powerCollected", self, "powerSkill"):
				power[i].connect("powerCollected", self, "powerSkill")		

func skillCheck():
	var skill = player.getCurrentSkill()
	skillDisplay.text = skill
	
func lifeCheck():
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
		BHPatternManager.deregister_other_collider(bulletClearArea)
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		
		
func _on_player_death():
	
	power = 0 
	freeze(0.01, 3)
	invert.visible = true
	yield(get_tree().create_timer(0.01 * 3), "timeout")
	
	invert.visible = false
	$Music/SFX/clearDeath.play()
	$Music/SFX/respawn.play()	
	appleNumber -= 2
	player.global_position = $Position2D.global_position	
	BHPatternManager.register_other_collider(bulletClearArea)
	if debug == false:
		life -= 1
		lifeCheck()		
	else:
		appleNumber -= 2
	


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
		
func lifeIncrease():
	life += 1
	lifeCheck()

func stageChange():
	stage += 1
	print(stage)
	#var loading = loadingScreen.instance()
	#get_node("GUI/Control/Loading").add_child(loading)
	if stage == 2:
		
		BHPatternManager.register_bullet_container(self)
		
		get_node("Stage/Stage1").queue_free()
		var stage2 = stage2Loaded.instance()
		get_node("Stage").add_child(stage2)
		stage2.ready()
		stage2.connect("changeStage", self, "stageChange")
		
	if stage == 3:
		print("game done")
		saveApples()
		get_tree().change_scene("res://Scenes/ending-cutscene.tscn")
		
func saveApples():
	var save = File.new()
	save.open(saveFile, File.WRITE)
	save.store_var(appleNumber)
	save.close()

#func getDebugMode():
#	var save = File.new()
#	if save.file_exists(saveFile):
#		save.open(saveFile, File.READ)
#		debug = save.get_var()
#
#	save.close()
	

func inputCheck():
	if Input.is_action_just_pressed("debug"):
		if debug == true:
			debug = false
		else:
			debug = true
	
	if Input.is_action_just_pressed("pause"):
		if paused == false:
			paused = true
			print(paused)
			$PausedGUI.ready()
			$PausedGUI.visible = true
			get_tree().paused = true
		elif paused == true:
			paused = false
			print(paused)
			$PausedGUI.visible = false
			get_tree().paused = false
