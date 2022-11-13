extends Node2D


onready var anim = $AnimationPlayer
onready var time = $Start
onready var bullStart = $bull

onready var add1 = load("res://Scenes/patterns/2add1.tscn")
onready var add2 = load("res://Scenes/patterns/2add8.tscn")
onready var owl1 = $Owl
onready var owl2 = $Owl2
onready var owl1Health = $Owl/Health
onready var owl2Health = $Owl2/Health
onready var owl1ref = weakref(owl1)
onready var owl2ref = weakref(owl2)
onready var owl1Pos = $Owl/Position2D
onready var owl2Pos = $Owl2/Position2D

onready var att1 = add1.instance()
onready var att2 = add1.instance()
onready var att3 = add2.instance()
onready var att4 = add2.instance()

onready var player = get_tree().get_nodes_in_group("player").front()

var canShoot = false

# Called when the node enters the scene tree for the first time.
func ready():
	if owl1ref.get_ref():
		owl1.ready()
		owl1Health.wait_time = 1
	if owl2ref.get_ref():
		owl2.ready()
		owl2Health.wait_time = 1
	anim.current_animation = "New Anim"
	time.start() #Starts timer
	
#Plays the first stage enemy form
func _on_Start_timeout():
	#anim.current_animation = "New Anim"
	
	if owl1ref.get_ref():
		owl1.add_child(att1)
		owl1.add_child(att3)
		#var at1 = att1.get_node("BulletPattern")
		att1.global_position = owl1.global_position
		att3.global_position = owl1.global_position
		#at1.global_position = owl1.global_position
		att1.set_aim_target(player)
		att3.set_aim_target(player)
	
	if owl2ref.get_ref():
		owl2.add_child(att2)
		owl2.add_child(att4)
		#var at2 = att2.get_node("BulletPattern")
		att2.global_position = owl2.global_position
		att4.global_position = owl2.global_position
		#at2.global_position = owl2.global_position
		att2.set_aim_target(player)
		att4.set_aim_target(player)
	
	BHPatternManager.register_bullet_container(get_parent())
	
	canShoot = true
	
	if canShoot == true:

		if owl1ref.get_ref():
			att1.global_position = owl1.global_position
			att3.global_position = owl1.global_position
			att1.set_aim_target(player)
			att1.enable()
			att3.enable()
			att3.disable()
			
		if owl2ref.get_ref():	
			att2.global_position = owl2.global_position
			att4.global_position = owl2.global_position
			#at2.global_position = owl2.global_position
			att2.set_aim_target(player)
			att2.enable()
			att4.enable()
			att4.disable()
		
		
		bullStart.start()
	

#Kills scene after some time
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

#Disable
func _on_bull_timeout():
	if owl1ref.get_ref():
		att1.disable()
		att3.disable()
	if owl2ref.get_ref():
		att2.disable()
		att4.disable()
