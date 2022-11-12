extends Node2D


onready var anim = $AnimationPlayer
onready var time = $Start
onready var bullStart = $bull

onready var add1 = load("res://Scenes/patterns/add4.tscn")
onready var add2 = load("res://Scenes/patterns/add10.tscn")
onready var add3 = load("res://Scenes/patterns/add7.tscn")
onready var add2Instanced = add2.instance()
onready var add3Instanced = add3.instance()
onready var owl1 = $Owl2
onready var owl2 = $Owl
onready var owl1Health = $Owl2/Health
onready var owl2Health = $Owl/Health
onready var owl1ref = weakref(owl1)
onready var owl2ref = weakref(owl2)
onready var owl1Pos = $Owl2/Position2D
onready var owl2Pos = $Owl/Position2D

onready var player = get_tree().get_nodes_in_group("player").front()

var canShoot = false
var canFire = true
var patternLoop = 5

# Called when the node enters the scene tree for the first time.
func ready():
	if owl1ref.get_ref():
		owl1.ready()
		owl1Health.wait_time = 3
	if owl2ref.get_ref():
		owl2.ready()
		owl2Health.wait_time = 10
	time.start() #Starts timer
	
#Plays the first stage enemy form
func _on_Start_timeout():
	anim.current_animation = "New Anim"
	$Shoot.start()
	
	if owl2ref.get_ref():
		owl2.add_child(add2Instanced)
		add2Instanced.global_position = owl2.global_position
	if owl1ref.get_ref():
		owl1.add_child(add3Instanced)
		add3Instanced.global_position = owl1.global_position

	
	
	BHPatternManager.register_bullet_container(get_parent())
	

	

#Kills scene after some time
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

#Disable
func _on_bull_timeout(att1):
	if owl1ref.get_ref():
		att1.disable()
		add2Instanced.disable()
	



func _on_Shoot_timeout():
	if owl2ref.get_ref():
		add2Instanced.enable()
		add2Instanced.global_position = owl2.global_position
	if owl1ref.get_ref():
		add3Instanced.enable()
		add3Instanced.global_position = owl1.global_position
		if canFire == true:
			for i in patternLoop:
				var att1 = add1.instance()
				#var att2 = add2.instance()
				owl1.add_child(att1)
				
				att1.global_position = owl1.global_position
				#att2.global_position = owl1.global_position

				att1.set_aim_target(player)
				att1.shell_settings.speed += 50
				att1.enable()
				att1.disable()
				canFire = false
				#att2.enable()
				
			
		
	bullStart.start()
